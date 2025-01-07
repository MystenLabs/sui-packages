module 0xbecd6e213cdc7c82cfac8807e0c9fd23f163216013117dc7ed226653991fe311::SmolderingAfflictedNoise {
    struct SMOLDERINGAFFLICTEDNOISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOLDERINGAFFLICTEDNOISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLDERINGAFFLICTEDNOISE>(arg0, 0, b"COS", b"Smoldering Afflicted Noise", b"They will heal themselves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Smoldering_Afflicted_Noise.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOLDERINGAFFLICTEDNOISE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOLDERINGAFFLICTEDNOISE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

