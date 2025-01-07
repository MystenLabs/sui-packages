module 0x5b053e29dc1bf564f206da2c12c8c1e74f69a39dcb42f2862328984e318ac03c::TheFrostedFestiveHat {
    struct THEFROSTEDFESTIVEHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEFROSTEDFESTIVEHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEFROSTEDFESTIVEHAT>(arg0, 0, b"COS", b"The Frosted Festive Hat", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_The_Frosted_Festive_Hat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEFROSTEDFESTIVEHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEFROSTEDFESTIVEHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

