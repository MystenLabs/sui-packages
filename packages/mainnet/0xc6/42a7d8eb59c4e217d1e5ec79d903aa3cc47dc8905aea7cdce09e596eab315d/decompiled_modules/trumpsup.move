module 0xc642a7d8eb59c4e217d1e5ec79d903aa3cc47dc8905aea7cdce09e596eab315d::trumpsup {
    struct TRUMPSUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUP>(arg0, 6, b"TRUMPSUP", b"TRUMPS UP", x"50757420796f7572207468756d62732075702c2069742773205452554d50532055502074696d650a0a5955502c2069742773205452554d5053204249472054494d45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730686265002.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPSUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

