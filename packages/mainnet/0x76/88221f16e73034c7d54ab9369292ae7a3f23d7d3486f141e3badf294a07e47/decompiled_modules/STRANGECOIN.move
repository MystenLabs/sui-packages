module 0x7688221f16e73034c7d54ab9369292ae7a3f23d7d3486f141e3badf294a07e47::STRANGECOIN {
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

