module 0x65ff2dd945583688d7122163df61fd43594e870c0af86a7bfd62ac5cf8debba6::SashoftheDen {
    struct SASHOFTHEDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHEDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHEDEN>(arg0, 0, b"COS", b"Sash of the Den", b"Left behind on a basking seraph...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Den.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHEDEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHEDEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

