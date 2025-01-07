module 0x80f1f8d100f16922793b24d90dd8206f7d68f07dcb220b3b7d511d74c506da7::harambe {
    struct HARAMBE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HARAMBE>, arg1: vector<0x2::coin::Coin<HARAMBE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<HARAMBE>>(&mut arg1);
        0x2::pay::join_vec<HARAMBE>(&mut v0, arg1);
        0x2::coin::burn<HARAMBE>(arg0, 0x2::coin::split<HARAMBE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<HARAMBE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<HARAMBE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<HARAMBE>(v0);
        };
    }

    fun init(arg0: HARAMBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HARAMBE>(arg0, 5, b"HARAMBE", b"HARAMBE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<HARAMBE>(&mut v3, 100000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAMBE>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARAMBE>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HARAMBE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HARAMBE>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<HARAMBE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HARAMBE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

