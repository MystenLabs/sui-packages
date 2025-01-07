module 0x353f787b32f090cb3804efda0fe9556fda39a4fe44f9d1187a800da717427d91::kek {
    struct KEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEK>(arg0, 6, b"KEK", b"Kekius Maximus", b"Elon's New Pet (KEK)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_12_31_9_50_51_PM_8007f783df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

