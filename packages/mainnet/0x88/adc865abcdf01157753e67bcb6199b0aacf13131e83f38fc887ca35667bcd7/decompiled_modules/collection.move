module 0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::collection {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
    }

    public(friend) fun display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"symbol"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{symbol}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x2::transfer::public_transfer<0x2::display::Display<Collection>>(0x2::display::new_with_fields<Collection>(arg0, v0, v2, arg1), @0xdfda63ad61f8ad5176c1107cb4a8377e3da14221221c3890d7f5a71a800dbbff);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"EnsoFi Early Contributor Pass"),
            symbol      : 0x1::string::utf8(b"ENSO"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://blush-deep-leech-408.mypinata.cloud/ipfs/QmV2bapSygGLsF8xTQYcQfa5f2PriNVV2SqJbAGupy42s3"),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://app.ensofi.xyz"),
        }
    }

    // decompiled from Move bytecode v6
}

