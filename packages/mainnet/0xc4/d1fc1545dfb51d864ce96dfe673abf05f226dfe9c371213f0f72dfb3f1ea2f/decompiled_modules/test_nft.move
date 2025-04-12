module 0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::test_nft {
    struct TestNft has store, key {
        id: 0x2::object::UID,
        collection_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        metadata_uri: 0x1::option::Option<0x1::string::String>,
        number: u64,
    }

    public(friend) fun new(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : TestNft {
        TestNft{
            id              : 0x2::object::new(arg5),
            collection_name : arg1,
            description     : arg2,
            image_url       : arg3,
            metadata_uri    : arg4,
            number          : arg0,
        }
    }

    public fun number(arg0: &TestNft) : u64 {
        arg0.number
    }

    // decompiled from Move bytecode v6
}

