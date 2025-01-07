module 0x6bfd52d63c084ed83c594a484a0c413ca2871f093c4826bd4d986c4231dbe907::frink {
    struct FRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRINK>(arg0, 6, b"FRINK", b"FRINKCOIN", b"$FRINK is the coin of prophecy, the coin of miracles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730647851262.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

