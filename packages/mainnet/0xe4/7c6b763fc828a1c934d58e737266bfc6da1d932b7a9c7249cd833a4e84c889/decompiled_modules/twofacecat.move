module 0xe47c6b763fc828a1c934d58e737266bfc6da1d932b7a9c7249cd833a4e84c889::twofacecat {
    struct TWOFACECAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TWOFACECAT>, arg1: vector<0x2::coin::Coin<TWOFACECAT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TWOFACECAT>>(&mut arg1);
        0x2::pay::join_vec<TWOFACECAT>(&mut v0, arg1);
        0x2::coin::burn<TWOFACECAT>(arg0, 0x2::coin::split<TWOFACECAT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TWOFACECAT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TWOFACECAT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TWOFACECAT>(v0);
        };
    }

    fun init(arg0: TWOFACECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmWoH5diSc6q2xAuPAFyaPHXS2iSGDAZwMTmQWfPmq1wfL"));
        let (v2, v3) = 0x2::coin::create_currency<TWOFACECAT>(arg0, 9, b"VENUS", b"TwoFaceCat", b"Chimerism, a genetic condition that gives Venus her multicolored face, is responsible for her appearance. https://www.tiktok.com/@venustwofacecat ", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWOFACECAT>>(v3);
        0x2::coin::mint_and_transfer<TWOFACECAT>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWOFACECAT>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TWOFACECAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TWOFACECAT>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TWOFACECAT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TWOFACECAT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

