module 0x317fb46ca4c694f32621b46d883c070144e353767a28dd65d20df009a90c86a4::EarsofOlympianFervor {
    struct EARSOFOLYMPIANFERVOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARSOFOLYMPIANFERVOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARSOFOLYMPIANFERVOR>(arg0, 0, b"COS", b"Ears of Olympian Fervor", b"Abliss in its demands... Divine in its devotion...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ears_of_Olympian_Fervor.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARSOFOLYMPIANFERVOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARSOFOLYMPIANFERVOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

