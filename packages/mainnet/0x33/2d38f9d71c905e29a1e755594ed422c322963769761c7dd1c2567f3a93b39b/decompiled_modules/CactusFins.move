module 0x332d38f9d71c905e29a1e755594ed422c322963769761c7dd1c2567f3a93b39b::CactusFins {
    struct CACTUSFINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTUSFINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTUSFINS>(arg0, 0, b"COS", b"Cactus Fins", b"Melted, but not without their teeth...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Cactus_Fins.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CACTUSFINS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTUSFINS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

