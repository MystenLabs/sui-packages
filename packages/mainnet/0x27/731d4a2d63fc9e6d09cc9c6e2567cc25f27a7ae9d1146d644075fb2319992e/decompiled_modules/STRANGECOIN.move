module 0x27731d4a2d63fc9e6d09cc9c6e2567cc25f27a7ae9d1146d644075fb2319992e::STRANGECOIN {
    struct STRANGECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRANGECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRANGECOIN>(arg0, 9, b"STRANGECOIN", b"STRANGECOIN", b"STRANGECOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRANGECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STRANGECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

