module 0xa21548a6174101326fc2a3b8be6639ad328a11a236c69f554b98562f578ff188::chillxmas {
    struct CHILLXMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLXMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLXMAS>(arg0, 6, b"CHILLXMAS", b"CHILL XMAS", b"Just a chill guy on christmass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3917_e312f57189.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLXMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLXMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

