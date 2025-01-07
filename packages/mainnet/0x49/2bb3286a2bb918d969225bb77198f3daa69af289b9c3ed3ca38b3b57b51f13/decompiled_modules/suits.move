module 0x492bb3286a2bb918d969225bb77198f3daa69af289b9c3ed3ca38b3b57b51f13::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITS>, arg1: vector<0x2::coin::Coin<SUITS>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUITS>>(&mut arg1);
        0x2::pay::join_vec<SUITS>(&mut v0, arg1);
        0x2::coin::burn<SUITS>(arg0, 0x2::coin::split<SUITS>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUITS>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUITS>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUITS>(v0);
        };
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SUITS>(arg0, 6, b"SUITS", b"SUITS", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUITS>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITS>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITS>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUITS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUITS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

