module 0xddae8e0932d50ea2fae175017181c067952243a149366e082146ea8e60b0d32c::WiltedListenerMushrooms {
    struct WILTEDLISTENERMUSHROOMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILTEDLISTENERMUSHROOMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILTEDLISTENERMUSHROOMS>(arg0, 0, b"COS", b"Wilted Listener Mushrooms", b"Dried out husks... still pulsing to the breath of the choir...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Wilted_Listener_Mushrooms.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WILTEDLISTENERMUSHROOMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILTEDLISTENERMUSHROOMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

