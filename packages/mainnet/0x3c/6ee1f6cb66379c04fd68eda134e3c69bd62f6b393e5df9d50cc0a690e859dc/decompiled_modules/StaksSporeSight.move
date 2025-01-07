module 0x3c6ee1f6cb66379c04fd68eda134e3c69bd62f6b393e5df9d50cc0a690e859dc::StaksSporeSight {
    struct STAKSSPORESIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKSSPORESIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAKSSPORESIGHT>(arg0, 0, b"COS", b"Stak's Spore Sight", b"Careful, now... Strain not the gaze beyond...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Staks_Spore_Sight.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAKSSPORESIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAKSSPORESIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

