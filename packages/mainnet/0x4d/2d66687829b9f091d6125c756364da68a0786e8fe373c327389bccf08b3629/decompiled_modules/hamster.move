module 0x4d2d66687829b9f091d6125c756364da68a0786e8fe373c327389bccf08b3629::hamster {
    struct HAMSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTER>(arg0, 6, b"HAMSTER", b"SUI HAMSTER", b"hamster living a good life. sleep, eat, play. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIHAMSTER_ef45ade4fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

