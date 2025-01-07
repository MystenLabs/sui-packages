module 0xd91230c581a7144b1eed2eeeed88d1467191501f29954fe4d122986d873b7cd9::RivermireLobes {
    struct RIVERMIRELOBES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIVERMIRELOBES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIVERMIRELOBES>(arg0, 0, b"COS", b"Rivermire Lobes", b"A way out... there must be... listen...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Rivermire_Lobes.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIVERMIRELOBES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIVERMIRELOBES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

