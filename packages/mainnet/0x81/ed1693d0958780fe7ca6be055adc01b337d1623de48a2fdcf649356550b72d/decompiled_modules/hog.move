module 0x81ed1693d0958780fe7ca6be055adc01b337d1623de48a2fdcf649356550b72d::hog {
    struct HOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOG>(arg0, 6, b"HOG", b"Elon Hedgehog", b"\"Our hedgehog loves running on her wheel for hours!\" - Elon Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016488_becad93f1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

