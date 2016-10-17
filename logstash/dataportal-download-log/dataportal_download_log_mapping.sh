curl -XDELETE "http://$ESDBHOST:9200/logs"

curl -XPUT "http://$ESDBHOST:9200/logs/" -d '
{
	"index": {
		"analysis": {
			"filter": {
				"nGram_filter": {
					"type": "nGram",
					"min_gram": 2,
					"max_gram": 20,
					"token_chars": [
						"letter",
						"digit",
						"punctuation",
						"symbol"
					]
				},
				"snowball_spanish": {
					"type": "snowball",
					"language": "Spanish"
				},
				"stopwords": {
					"type": "stop",
					"stopwords": "_spanish_"
				},
				"worddelimiter": {
					"type": "word_delimiter"
				},
				"my_shingle_filter": {
					"type": "shingle",
					"min_shingle_size": "2",
					"max_shingle_size": "5",
					"output_unigrams": "false",
					"output_unigrams_if_no_shingles": "false"
				},
				"my_ascii_folding": {
					"type" : "asciifolding",
					"preserve_original": true
				},
				"spanish_stop": {
          "type": "stop",
          "stopwords": "_spanish_"
        },
        "spanish_stemmer": {
          "type": "stemmer",
          "language": "light_spanish"
        }
			},
			"analyzer": {
				"nGram_analyzer": {
					"type": "custom",
					"tokenizer": "whitespace",
					"filter": [
						"lowercase",
						"asciifolding",
						"nGram_filter"
					]
				},
				"whitespace_analyzer": {
					"type": "custom",
					"tokenizer": "whitespace",
					"filter": [
						"lowercase",
						"asciifolding"
					]
				},
				"spanish": {
					"type": "custom",
					"tokenizer": "standard",
					"filter": ["lowercase", "stopwords", "my_ascii_folding", "snowball_spanish", "worddelimiter"]
				},
				"spanish_search_analyzer": {
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "spanish_stop",
            "my_ascii_folding",
            "snowball_spanish"
          ]
        },
				"my_shingle_analyzer": {
					"type": "custom",
					"tokenizer": "standard",
					"filter": ["lowercase", "my_shingle_filter"]
				},
				"string_lowercase": {
					"tokenizer": "keyword",
					"filter": ["lowercase"]
				}
			}
		}
	}
}'

curl -XPUT "http://$ESDBHOST:9200/logs/_mapping/dataportal_downloads" -d '
{
	"dataportal_downloads" :  {
		"properties": {
			"reason":  {
				"type": "string",
				"index": "analyzed",
				"fields": {
					"untouched" : {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					}
				}
			},
			"geoip": {
				"type" : "geo_point",
				"lat_lon": true,
				"geohash": true,
				"geohash_prefix": true,
				"geohash_precision": 6
			},
			"level":  {
				"type": "string",
				"index": "analyzed",
				"fields": {
					"untouched" : {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					}
				}
			},
			"pid": {"type" : "long"},
			"fileSize": {"type" : "double"},
			"totalRegisters": {"type" : "long"},
			"email" :  {
				"type": "string",
				"index": "analyzed",
				"fields" : {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					}
				}
			},
			"message" : {
				"type": "string",
				"index": "analyzed",
				"fields" : {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					}
				}
			},
			"type" :  {
				"type": "string",
				"index": "analyzed",
				"fields" : {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					}
				}
			},
			"host" :  {
				"type": "string",
				"index": "analyzed",
				"fields" : {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					}
				}
			},
			"path" :  {
				"type": "string",
				"index": "analyzed",
				"fields" : {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					}
				}
			},
			"requestDate": {
				"type": "date",
				"format": "dateOptionalTime"
			},
			"processFinishDate": {
				"type": "date",
				"format": "dateOptionalTime"
			},
			"@timestamp": {
				"type": "date",
				"format": "dateOptionalTime"
			},
			"@version": {
				"type": "string"
			}
		}
	}
}'
