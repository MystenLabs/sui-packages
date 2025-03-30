module 0x36b4d56faa726e6a025f65aaa8b816fad195d9dc719eda6fa3f12c5120a99932::main {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimTracker has store, key {
        id: 0x2::object::UID,
        claimed: 0x2::vec_map::VecMap<address, bool>,
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ClaimTracker{
            id      : 0x2::object::new(arg0),
            claimed : 0x2::vec_map::empty<address, bool>(),
        };
        0x2::transfer::public_share_object<ClaimTracker>(v1);
    }

    public entry fun mint_nft(arg0: &AdminCap, arg1: &mut ClaimTracker, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_map::contains<address, bool>(&arg1.claimed, &v0), 0);
        let v1 = NFT{
            id        : 0x2::object::new(arg4),
            name      : 0x1::string::utf8(arg2),
            image_url : 0x1::string::utf8(arg3),
        };
        0x2::vec_map::insert<address, bool>(&mut arg1.claimed, v0, true);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

