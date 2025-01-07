module 0x8d71fd34152869b63ca379f7b4b29d491cea01befd17603f79a4505e73bfcaae::MageweedListenerMushrooms {
    struct MAGEWEEDLISTENERMUSHROOMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGEWEEDLISTENERMUSHROOMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGEWEEDLISTENERMUSHROOMS>(arg0, 0, b"COS", b"Mageweed Listener Mushrooms", b"Curse these frightening cries... push the nightmare away...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Mageweed_Listening_Mushrooms.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGEWEEDLISTENERMUSHROOMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGEWEEDLISTENERMUSHROOMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

