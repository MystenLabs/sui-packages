module 0x2f73afaecc6169cb45d81d295cdff3868d274a11d910061ff4c22815b67ff41a::Mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    struct MarioNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct MarioCollection has store, key {
        id: 0x2::object::UID,
        totalSupply: u64,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarioCollection{
            id          : 0x2::object::new(arg1),
            totalSupply : 0,
        };
        0x2::transfer::share_object<MarioCollection>(v0);
        0x2::package::claim_and_keep<MARIO>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarioNFT{
            id      : 0x2::object::new(arg0),
            name    : 0x1::string::utf8(b"Mario"),
            img_url : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmQPK5Dq1TWJ6StbxNwLC19EdsAbSKJgZY4FNqsbcFWS6k/13946.png"),
        };
        0x2::transfer::transfer<MarioNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

