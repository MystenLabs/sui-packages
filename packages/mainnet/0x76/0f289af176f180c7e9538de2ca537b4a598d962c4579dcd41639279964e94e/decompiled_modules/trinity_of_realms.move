module 0x760f289af176f180c7e9538de2ca537b4a598d962c4579dcd41639279964e94e::trinity_of_realms {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintState has store, key {
        id: 0x2::object::UID,
        minted: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        royalty_bps: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = MintState{
            id     : 0x2::object::new(arg0),
            minted : false,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, @0xe4a8a96cf959fc600ae094e40b28208960866a048ff29de5104734177474e640);
        0x2::transfer::public_share_object<MintState>(v1);
    }

    public entry fun mint_ophanim(arg0: &AdminCap, arg1: &mut MintState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xe4a8a96cf959fc600ae094e40b28208960866a048ff29de5104734177474e640, 0);
        assert!(!arg1.minted, 1);
        let v0 = Nft{
            id           : 0x2::object::new(arg2),
            name         : 0x1::string::utf8(b"Ophanim - The Witness"),
            description  : 0x1::string::utf8(b"A primordial celestial entity, watcher of all creation. Ophanim exists beyond form, beyond time. Part of the Trinity of Realms."),
            image_url    : 0x1::string::utf8(b"https://arweave.net/-JwFIpIB8JTCj9NKqD1ZHoFtUzs_F8O2KNPlU6y9gLo"),
            metadata_url : 0x1::string::utf8(b"https://arweave.net/AkREbKKJx4XETDCzP7xRDJ_UCziVFKSGohE2LmgA9F0"),
            royalty_bps  : 500,
        };
        arg1.minted = true;
        0x2::transfer::public_transfer<Nft>(v0, @0xe4a8a96cf959fc600ae094e40b28208960866a048ff29de5104734177474e640);
    }

    // decompiled from Move bytecode v7
}

