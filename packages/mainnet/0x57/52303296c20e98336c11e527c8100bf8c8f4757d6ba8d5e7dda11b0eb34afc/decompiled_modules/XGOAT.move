module 0x5752303296c20e98336c11e527c8100bf8c8f4757d6ba8d5e7dda11b0eb34afc::XGOAT {
    struct XGOAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XGOAT>, arg1: vector<0x2::coin::Coin<XGOAT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<XGOAT>>(&mut arg1);
        0x2::pay::join_vec<XGOAT>(&mut v0, arg1);
        0x2::coin::burn<XGOAT>(arg0, 0x2::coin::split<XGOAT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<XGOAT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<XGOAT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<XGOAT>(v0);
        };
    }

    fun init(arg0: XGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XGOAT>(arg0, 6, b"xGOAT", b"xGOAT", b"xGOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWq2LAVJm5hYVmPEd6Cz3ccuKuNv4czMoCq6sVz3cZ1r1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XGOAT>(&mut v2, 10000000000000000000, @0x909518533b3418168598af4fd929981f64d46a763ddc0e997dc32e53776194f3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XGOAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGOAT>>(v2, @0x909518533b3418168598af4fd929981f64d46a763ddc0e997dc32e53776194f3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XGOAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

