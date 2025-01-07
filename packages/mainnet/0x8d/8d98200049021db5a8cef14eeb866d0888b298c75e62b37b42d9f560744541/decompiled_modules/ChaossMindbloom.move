module 0x8d8d98200049021db5a8cef14eeb866d0888b298c75e62b37b42d9f560744541::ChaossMindbloom {
    struct CHAOSSMINDBLOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAOSSMINDBLOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOSSMINDBLOOM>(arg0, 0, b"COS", b"Chaos's Mindbloom", b"Blossom not with the seasons; ours is a ceaseless place.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_chaoss_Mindbloom.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAOSSMINDBLOOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAOSSMINDBLOOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

