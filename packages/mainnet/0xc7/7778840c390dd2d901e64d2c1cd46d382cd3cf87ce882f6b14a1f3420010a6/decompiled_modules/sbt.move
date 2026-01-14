module 0xc77778840c390dd2d901e64d2c1cd46d382cd3cf87ce882f6b14a1f3420010a6::sbt {
    struct SoulboundToken has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        blob_id: 0x1::string::String,
    }

    struct SBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator.mainnet.walrus.space/v1/blobs/{blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://walrus.xyz"));
        let v4 = 0x2::package::claim<SBT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SoulboundToken>(&v4, v0, v2, arg1);
        0x2::display::update_version<SoulboundToken>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SoulboundToken>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SoulboundToken{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            blob_id     : arg2,
        };
        0x2::transfer::transfer<SoulboundToken>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

