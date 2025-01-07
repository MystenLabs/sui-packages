module 0x7d816cabd1b9c1e670249c99f5234c30f86fc8acfdb11e1e3a4a53c050184ead::suitzerland {
    struct SUITZERLAND has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITZERLAND>, arg1: vector<0x2::coin::Coin<SUITZERLAND>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUITZERLAND>>(&mut arg1);
        0x2::pay::join_vec<SUITZERLAND>(&mut v0, arg1);
        0x2::coin::burn<SUITZERLAND>(arg0, 0x2::coin::split<SUITZERLAND>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUITZERLAND>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUITZERLAND>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUITZERLAND>(v0);
        };
    }

    fun init(arg0: SUITZERLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Bandera_de_Suiza.png/640px-Bandera_de_Suiza.png"));
        let (v2, v3) = 0x2::coin::create_currency<SUITZERLAND>(arg0, 8, b"Suitzerland", b"Suitzerland", b"hold", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITZERLAND>>(v3);
        0x2::coin::mint_and_transfer<SUITZERLAND>(&mut v4, 10000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITZERLAND>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITZERLAND>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITZERLAND>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUITZERLAND>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUITZERLAND>>(arg0);
    }

    // decompiled from Move bytecode v6
}

