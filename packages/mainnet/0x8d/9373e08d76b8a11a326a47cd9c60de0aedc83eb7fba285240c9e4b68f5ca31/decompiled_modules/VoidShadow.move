module 0x8d9373e08d76b8a11a326a47cd9c60de0aedc83eb7fba285240c9e4b68f5ca31::VoidShadow {
    struct VOIDSHADOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOIDSHADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOIDSHADOW>(arg0, 0, b"COS", b"VoidShadow", b"Little one, are you frightened?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_VoidShadow.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOIDSHADOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOIDSHADOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

