module 0x5a93a611a972619cde7202e93dcde9888a373f163e5c4bb0bd803844bace6b57::DOGE {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 9, b"DOGE", b"DOGE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://graiscale.fun/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGE>>(0x2::coin::mint<DOGE>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

