module 0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::erc721_metadata {
    struct STACCNftMetadata has drop, store {
        token_id: TokenID,
        name: 0x1::string::String,
        token_uri: 0x2::url::Url,
    }

    struct TokenID has copy, drop, store {
        id: u256,
    }

    public fun name(arg0: &STACCNftMetadata) : &0x1::string::String {
        &arg0.name
    }

    public fun new(arg0: TokenID, arg1: vector<u8>, arg2: vector<u8>) : STACCNftMetadata {
        STACCNftMetadata{
            token_id  : arg0,
            name      : 0x1::string::utf8(arg1),
            token_uri : 0x2::url::new_unsafe(0x1::ascii::string(arg2)),
        }
    }

    public fun new_token_id(arg0: u256) : TokenID {
        TokenID{id: arg0}
    }

    public fun token_id(arg0: &STACCNftMetadata) : &TokenID {
        &arg0.token_id
    }

    public fun token_uri(arg0: &STACCNftMetadata) : &0x2::url::Url {
        &arg0.token_uri
    }

    // decompiled from Move bytecode v6
}

