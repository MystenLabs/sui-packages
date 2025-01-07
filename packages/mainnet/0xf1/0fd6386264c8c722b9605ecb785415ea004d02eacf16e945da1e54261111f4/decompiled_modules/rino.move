module 0xf10fd6386264c8c722b9605ecb785415ea004d02eacf16e945da1e54261111f4::rino {
    struct RINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINO>(arg0, 6, b"RINO", b"Rino on SUI", b"Memecoin RINO Hamster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965235410.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

