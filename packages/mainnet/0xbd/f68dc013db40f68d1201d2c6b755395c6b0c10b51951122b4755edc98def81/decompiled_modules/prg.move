module 0xbdf68dc013db40f68d1201d2c6b755395c6b0c10b51951122b4755edc98def81::prg {
    struct PRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRG>(arg0, 6, b"Prg", b"Poring", b"The true meme token on $SUI blockchain with fair distribution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971324491.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

