module 0x924227f5edcba1f2900ba6c712bd9df61b886c3c02e6fe6ee077b96a83a28c60::hopp {
    struct HOPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPP>(arg0, 6, b"HOPP", b"Hop Bunny", b"One sunny day, he discovered a hidden path that led to a sparkling stream, where he met a wise old turtle who shared stories of adventure and friendship. From that day on, Bunny learned the importance of curiosity and the joy of making new friends!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731273206260.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

