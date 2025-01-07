module 0x505f35c882470f6147adf0db00bbca1d2f916b9cafdecea33e0d8bfd456176d::BloomingListenerMushrooms {
    struct BLOOMINGLISTENERMUSHROOMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOMINGLISTENERMUSHROOMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOMINGLISTENERMUSHROOMS>(arg0, 0, b"COS", b"Blooming Listener Mushrooms", b"Radiant with spores from Grand Fungus... spread far...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Blooming_Listener_Mushrooms.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOOMINGLISTENERMUSHROOMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOMINGLISTENERMUSHROOMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

