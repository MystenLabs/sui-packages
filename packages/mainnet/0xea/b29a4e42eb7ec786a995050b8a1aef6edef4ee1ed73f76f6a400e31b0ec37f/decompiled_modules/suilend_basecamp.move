module 0xeab29a4e42eb7ec786a995050b8a1aef6edef4ee1ed73f76f6a400e31b0ec37f::suilend_basecamp {
    struct SuilendBasecamp has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUILEND_BASECAMP has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: SuilendBasecamp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SuilendBasecamp>(arg0, arg1);
    }

    public fun burn(arg0: SuilendBasecamp, arg1: &mut 0x2::tx_context::TxContext) {
        let SuilendBasecamp { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: SUILEND_BASECAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suilend x Sui Basecamp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A commemorative NFT for Sui Basecamp attendees on April 10-11 in Paris, France."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/V1+-+Suilend-x-SUI-Basecamp.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/V2+-+NFT-Basecamp-Resized.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend.fi"));
        let v4 = 0x2::package::claim<SUILEND_BASECAMP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuilendBasecamp>(&v4, v0, v2, arg1);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::display::update_version<SuilendBasecamp>(&mut v5);
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuilendBasecamp>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_addresses(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = SuilendBasecamp{id: 0x2::object::new(arg2)};
            0x2::transfer::transfer<SuilendBasecamp>(v1, 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

