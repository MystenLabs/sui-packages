module 0x58a4023d6a04120553c3765799a6077a99d5f790cf137819f2bb80cc084dd279::mins {
    struct MINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINS>(arg0, 9, b"MINS", b"Murad Insiders", b"The previous team just did a rug and I want to take it. They already deleted all X and Tg accounts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

