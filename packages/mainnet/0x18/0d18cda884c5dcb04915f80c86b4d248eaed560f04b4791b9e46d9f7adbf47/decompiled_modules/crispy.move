module 0x180d18cda884c5dcb04915f80c86b4d248eaed560f04b4791b9e46d9f7adbf47::crispy {
    struct CRISPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRISPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRISPY>(arg0, 6, b"CRISPY", b"CRISPY DOG", b"Crunch Crunch. I just love to crunch! Let's crunch together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20_cc19d32390.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRISPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRISPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

