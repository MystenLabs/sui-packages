module 0xabeaedab6de550fc4b71cb571b9829d7cd096ce5353182e8839be98156a5216d::meki {
    struct MEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKI>(arg0, 9, b"MEKI", b"Meki", b"JUST WANT MEKI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<MEKI>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKI>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

