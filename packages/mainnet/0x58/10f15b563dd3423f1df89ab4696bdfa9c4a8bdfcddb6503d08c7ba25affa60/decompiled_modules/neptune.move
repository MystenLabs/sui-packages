module 0x5810f15b563dd3423f1df89ab4696bdfa9c4a8bdfcddb6503d08c7ba25affa60::neptune {
    struct NEPTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNE>(arg0, 6, b"NEPTUNE", b"Neptune Protocol", x"4e657074756e652050726f746f636f6c20697320616e20697373756572206f6620746865205553444e20737461626c65636f696e20616e642061206c656e64696e6720706c6174666f726d206261736564206f6e205375692e205468652070726f6a656374207465616d20616c736f20706c616e7320746f206c61756e63682061206e6174697665204e505420746f6b656e2c2077686963682077696c6c20736572766520746f207265776172642075736572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735838731519.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEPTUNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

