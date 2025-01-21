module 0xd6801875344034061522c00a29f1951c1fde8d59d8dbefd9e915e80312f77f26::djtrump {
    struct DJTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJTRUMP>(arg0, 6, b"DJTRUMP", b"Make America Dance Again", b"DJTRUMP: Make America Dance Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_040320_712_158be13182.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

