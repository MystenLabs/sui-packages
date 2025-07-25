module 0x47c65286b9150896b216a623c92d4832839339b37a9237684e7c22373ecd20fe::test_nft {
    struct TestNft has store, key {
        id: 0x2::object::UID,
        collection_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        number: u64,
        attributes: 0x1::option::Option<0x47c65286b9150896b216a623c92d4832839339b37a9237684e7c22373ecd20fe::attributes::Attributes>,
    }

    public(friend) fun new(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x47c65286b9150896b216a623c92d4832839339b37a9237684e7c22373ecd20fe::attributes::Attributes>, arg5: &mut 0x2::tx_context::TxContext) : TestNft {
        TestNft{
            id              : 0x2::object::new(arg5),
            collection_name : arg1,
            description     : arg2,
            image_url       : arg3,
            number          : arg0,
            attributes      : arg4,
        }
    }

    public fun number(arg0: &TestNft) : u64 {
        arg0.number
    }

    public(friend) fun set_attributes(arg0: &mut TestNft, arg1: 0x47c65286b9150896b216a623c92d4832839339b37a9237684e7c22373ecd20fe::attributes::Attributes) {
        assert!(0x1::option::is_none<0x47c65286b9150896b216a623c92d4832839339b37a9237684e7c22373ecd20fe::attributes::Attributes>(&arg0.attributes), 1);
        0x1::option::fill<0x47c65286b9150896b216a623c92d4832839339b37a9237684e7c22373ecd20fe::attributes::Attributes>(&mut arg0.attributes, arg1);
    }

    public(friend) fun set_image_url(arg0: &mut TestNft, arg1: 0x1::string::String) {
        0x1::option::swap_or_fill<0x1::string::String>(&mut arg0.image_url, arg1);
    }

    // decompiled from Move bytecode v6
}

