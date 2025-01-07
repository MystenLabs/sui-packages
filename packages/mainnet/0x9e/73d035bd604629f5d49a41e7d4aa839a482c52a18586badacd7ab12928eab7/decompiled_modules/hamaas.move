module 0x9e73d035bd604629f5d49a41e7d4aa839a482c52a18586badacd7ab12928eab7::hamaas {
    struct HAMAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMAAS>(arg0, 6, b"Hamaas", b"Hamas", b"Do you condemn KHAAAMAS???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3063_1870d8c5b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMAAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMAAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

