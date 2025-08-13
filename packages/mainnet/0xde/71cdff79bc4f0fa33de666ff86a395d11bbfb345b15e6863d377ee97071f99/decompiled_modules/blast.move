module 0xde71cdff79bc4f0fa33de666ff86a395d11bbfb345b15e6863d377ee97071f99::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 9, b"BLAST", b"BLAST", b"BLAST YEAH FUN DOT FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLAST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v2, @0xae3c403cb6ccf60f619bf7116f4f2c3c6c26b01415bc3a2e5f9ac755a0aa4b1f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

