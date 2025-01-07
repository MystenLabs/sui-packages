module 0xf2285baee89d34f52d4ed000611e57c4bb60201caac84e25c59bdd4e9f8cca77::bearcoin {
    struct BEARCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEARCOIN>, arg1: vector<0x2::coin::Coin<BEARCOIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BEARCOIN>>(&mut arg1);
        0x2::pay::join_vec<BEARCOIN>(&mut v0, arg1);
        0x2::coin::burn<BEARCOIN>(arg0, 0x2::coin::split<BEARCOIN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BEARCOIN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BEARCOIN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BEARCOIN>(v0);
        };
    }

    fun init(arg0: BEARCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BEARCOIN>(arg0, 6, b"BRR", b"BEARCOIN", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BEARCOIN>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARCOIN>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARCOIN>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEARCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEARCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BEARCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEARCOIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

