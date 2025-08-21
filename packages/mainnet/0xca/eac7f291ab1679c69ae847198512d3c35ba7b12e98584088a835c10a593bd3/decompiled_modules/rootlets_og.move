module 0xcaeac7f291ab1679c69ae847198512d3c35ba7b12e98584088a835c10a593bd3::rootlets_og {
    struct RootletsOG has store, key {
        id: 0x2::object::UID,
        rarity: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ROOTLETS_OG has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: RootletsOG, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RootletsOG>(arg0, arg1);
    }

    public fun burn(arg0: RootletsOG, arg1: &mut 0x2::tx_context::TxContext) {
        let RootletsOG {
            id     : v0,
            rarity : _,
            name   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: ROOTLETS_OG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This NFT is a token of appreciation awarded to Rootlets holders."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/{rarity}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suilend-assets.s3.us-east-2.amazonaws.com/{rarity}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rootlets.io/"));
        let v4 = 0x2::package::claim<ROOTLETS_OG>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<RootletsOG>(&v4, v0, v2, arg1);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::display::update_version<RootletsOG>(&mut v5);
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RootletsOG>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_addresses(arg0: &AdminCap, arg1: vector<address>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = RootletsOG{
                id     : 0x2::object::new(arg4),
                rarity : arg2,
                name   : arg3,
            };
            0x2::transfer::transfer<RootletsOG>(v1, 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
    }

    public fun rarity(arg0: &RootletsOG) : 0x1::string::String {
        arg0.rarity
    }

    // decompiled from Move bytecode v6
}

