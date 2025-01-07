module 0xf7d0f6a9da64c74dd93883e2bb0869675223b6f8a725508b85c02c3e75ab7d08::SingedEarsoftheMount {
    struct SINGEDEARSOFTHEMOUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINGEDEARSOFTHEMOUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINGEDEARSOFTHEMOUNT>(arg0, 0, b"COS", b"Singed Ears of the Mount", b"Listen for the crackle of flames, a whisper of Highland treasure...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Singed_Ears_of_the_Mount.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINGEDEARSOFTHEMOUNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINGEDEARSOFTHEMOUNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

