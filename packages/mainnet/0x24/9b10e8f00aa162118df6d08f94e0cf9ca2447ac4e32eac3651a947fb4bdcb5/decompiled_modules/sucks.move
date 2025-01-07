module 0x249b10e8f00aa162118df6d08f94e0cf9ca2447ac4e32eac3651a947fb4bdcb5::sucks {
    struct SUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCKS>(arg0, 6, b"Sucks", b"SUI Sucks", b"SUI Sucks my Asian Balls. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sucks_4cea188dfb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

