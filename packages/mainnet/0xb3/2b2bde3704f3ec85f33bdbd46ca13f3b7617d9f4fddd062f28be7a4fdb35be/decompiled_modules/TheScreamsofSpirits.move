module 0xb32b2bde3704f3ec85f33bdbd46ca13f3b7617d9f4fddd062f28be7a4fdb35be::TheScreamsofSpirits {
    struct THESCREAMSOFSPIRITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THESCREAMSOFSPIRITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THESCREAMSOFSPIRITS>(arg0, 0, b"COS", b"The Screams of Spirits", b"They beg not to be released... but rather sealed away... silenced for eternity...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_The_Screams_of_Spirits.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THESCREAMSOFSPIRITS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THESCREAMSOFSPIRITS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

