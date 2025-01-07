module 0xd0def119e85ae3554651e56281eed5efb0cf2715aa66f707fcb4123e36d84af6::AfflictedVisions {
    struct AFFLICTEDVISIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFFLICTEDVISIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFFLICTEDVISIONS>(arg0, 0, b"COS", b"Afflicted Visions", b"Cascade of terror... travesty of gaze... Turn not away from us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Afflicted_Visions.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFFLICTEDVISIONS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFFLICTEDVISIONS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

