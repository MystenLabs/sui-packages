module 0x2fb1289eb4e9ef987c6e383be4a9b298ef96d10a3f29060aaef39a0f9ecfbe6::suilend_beta_pass {
    struct SuilendBetaPass has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUILEND_BETA_PASS has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: SuilendBetaPass, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SuilendBetaPass>(arg0, arg1);
    }

    public fun burn(arg0: SuilendBetaPass, arg1: &mut 0x2::tx_context::TxContext) {
        let SuilendBetaPass { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: SUILEND_BETA_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suilend Beta Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This Beta Pass gives early access to Suilend."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/Suilend_NFT_Vday24.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/Suilend_NFT_Optimized_V4_512x512.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend.fi"));
        let v4 = 0x2::package::claim<SUILEND_BETA_PASS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuilendBetaPass>(&v4, v0, v2, arg1);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::display::update_version<SuilendBetaPass>(&mut v5);
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuilendBetaPass>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_addresses(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = SuilendBetaPass{id: 0x2::object::new(arg2)};
            0x2::transfer::transfer<SuilendBetaPass>(v1, 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

