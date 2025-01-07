module 0x22cdc18b03675fd223d7d251e9e94466d0c26899c6bc23382c0f0f4f4d08ba6d::suite {
    struct SUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITE>(arg0, 9, b"SUITE", b"Suite", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/wPz1Mb1.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

