module 0xf47377e5f44cbdb608e05c1d9f5ec3fb167272470316166ed83c1ed14d346619::AIGENT {
    struct AIGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIGENT>(arg0, 9, b"AIGENT", b"AIGENT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIGENT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIGENT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIGENT>>(0x2::coin::mint<AIGENT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

