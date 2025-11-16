module 0xf8938ac76060892c12105bb2901ba72c3b800f46028bd65046184a4b5ee5c3dd::social_creator {
    struct NFTSOCIAL has store, key {
        id: 0x2::object::UID,
        creator_name: 0x1::string::String,
        creator_handle: 0x1::string::String,
        xp: u64,
        level: u8,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_xp(arg0: &mut NFTSOCIAL, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.xp = arg0.xp + arg1;
        if (arg0.xp >= 100) {
            arg0.level = 2;
        };
        if (arg0.xp >= 500) {
            arg0.level = 3;
        };
        if (arg0.xp >= 1000) {
            arg0.level = 4;
        };
    }

    public fun get_level(arg0: &NFTSOCIAL) : u8 {
        arg0.level
    }

    public fun get_xp(arg0: &NFTSOCIAL) : u64 {
        arg0.xp
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_social_nft(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTSOCIAL{
            id             : 0x2::object::new(arg4),
            creator_name   : 0x1::string::utf8(arg1),
            creator_handle : 0x1::string::utf8(arg2),
            xp             : 0,
            level          : 1,
        };
        0x2::transfer::public_transfer<NFTSOCIAL>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

