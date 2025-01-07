module 0xf8670090c87793c18b16634600457d4778c7276eab4f86af8829450407780b8b::chansui {
    struct CHANSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHANSUI>, arg1: vector<0x2::coin::Coin<CHANSUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<CHANSUI>>(&mut arg1);
        0x2::pay::join_vec<CHANSUI>(&mut v0, arg1);
        0x2::coin::burn<CHANSUI>(arg0, 0x2::coin::split<CHANSUI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<CHANSUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CHANSUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<CHANSUI>(v0);
        };
    }

    fun init(arg0: CHANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"data:image/jpeg"));
        let (v2, v3) = 0x2::coin::create_currency<CHANSUI>(arg0, 7, b"Csui", b"Chansui", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHANSUI>>(v3);
        0x2::coin::mint_and_transfer<CHANSUI>(&mut v4, 300000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANSUI>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHANSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHANSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<CHANSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHANSUI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

