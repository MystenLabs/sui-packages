module 0xba7a0478a6a67b96668e47d3cedfe6fdba268615c6f215eaef0515e73be9940c::erc721_metadata {
    struct ERC721Metadata has store {
        token_id: TokenID,
        name: 0x1::string::String,
        token_uri: 0x2::url::Url,
    }

    struct TokenID has copy, store {
        id: u256,
    }

    public fun name(arg0: &ERC721Metadata) : &0x1::string::String {
        &arg0.name
    }

    public fun new(arg0: TokenID, arg1: vector<u8>, arg2: vector<u8>) : ERC721Metadata {
        ERC721Metadata{
            token_id  : arg0,
            name      : 0x1::string::utf8(arg1),
            token_uri : 0x2::url::new_unsafe(0x1::ascii::string(arg2)),
        }
    }

    public fun new_token_id(arg0: u256) : TokenID {
        TokenID{id: arg0}
    }

    public fun token_id(arg0: &ERC721Metadata) : &TokenID {
        &arg0.token_id
    }

    public fun token_uri(arg0: &ERC721Metadata) : &0x2::url::Url {
        &arg0.token_uri
    }

    // decompiled from Move bytecode v6
}

