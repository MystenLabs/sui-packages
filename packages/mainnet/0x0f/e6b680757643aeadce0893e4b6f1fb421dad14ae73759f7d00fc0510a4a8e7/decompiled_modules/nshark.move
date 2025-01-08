module 0xfe6b680757643aeadce0893e4b6f1fb421dad14ae73759f7d00fc0510a4a8e7::nshark {
    struct NSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSHARK>(arg0, 6, b"NSHARK", b"Nytan Shark", b"Nytan Shark is a fun memecoin that combines the iconic Nytan Cat with a playful shark theme, fostering community engagement and supporting ocean conservation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736344399201.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSHARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSHARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

