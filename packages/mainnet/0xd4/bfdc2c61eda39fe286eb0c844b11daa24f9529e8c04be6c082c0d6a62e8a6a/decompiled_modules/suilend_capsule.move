module 0xd4bfdc2c61eda39fe286eb0c844b11daa24f9529e8c04be6c082c0d6a62e8a6a::suilend_capsule {
    struct SuilendCapsule has store, key {
        id: 0x2::object::UID,
        rarity: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUILEND_CAPSULE has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: SuilendCapsule, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SuilendCapsule>(arg0, arg1);
    }

    public fun burn(arg0: SuilendCapsule, arg1: &mut 0x2::tx_context::TxContext) {
        let SuilendCapsule {
            id     : v0,
            rarity : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: SUILEND_CAPSULE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suilend Capsule"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This capsule is a token of appreciation awarded for outstanding community contributions."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/capsules/{rarity}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/capsules/{rarity}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend.fi"));
        let v4 = 0x2::package::claim<SUILEND_CAPSULE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuilendCapsule>(&v4, v0, v2, arg1);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::display::update_version<SuilendCapsule>(&mut v5);
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuilendCapsule>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_addresses(arg0: &AdminCap, arg1: vector<address>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = SuilendCapsule{
                id     : 0x2::object::new(arg3),
                rarity : arg2,
            };
            0x2::transfer::transfer<SuilendCapsule>(v1, 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
    }

    public fun rarity(arg0: &SuilendCapsule) : 0x1::string::String {
        arg0.rarity
    }

    // decompiled from Move bytecode v6
}

