module 0x3192f2b8f429140a1410a628dd7567513ba4a03d30ec0749859e9652bade0a0d::AWarmHug {
    struct AWARMHUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWARMHUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWARMHUG>(arg0, 0, b"COS", b"A Warm Hug", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Warm_Hug.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWARMHUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWARMHUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

