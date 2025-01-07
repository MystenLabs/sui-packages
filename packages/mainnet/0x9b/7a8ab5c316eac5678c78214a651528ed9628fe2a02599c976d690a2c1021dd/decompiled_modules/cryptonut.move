module 0x9b7a8ab5c316eac5678c78214a651528ed9628fe2a02599c976d690a2c1021dd::cryptonut {
    struct CRYPTONUT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CRYPTONUT>, arg1: 0x2::coin::Coin<CRYPTONUT>) {
        0x2::coin::burn<CRYPTONUT>(arg0, arg1);
    }

    fun init(arg0: CRYPTONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTONUT>(arg0, 6, b"CRYPTONUT", b"CNT", b"The token for the people crazy about crypto and what it enables", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://magenta-dull-boar-570.mypinata.cloud/ipfs/QmQiibQhLfDWoJAEK7TjFGxSauqyKKTPP6bn8B4MJ7kwGY")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTONUT>>(v1);
        0x2::coin::mint_and_transfer<CRYPTONUT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTONUT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

