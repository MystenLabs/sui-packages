module 0x522a87e29dd4f5cc04260927cf0dd7774eb814958ca6dc232767e7250ea28ced::CalloftheAbyss {
    struct CALLOFTHEABYSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALLOFTHEABYSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALLOFTHEABYSS>(arg0, 0, b"COS", b"Call of the Abyss", b"Chasm bedrock... screams of a thousand shells...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Call_of_the_Abyss.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CALLOFTHEABYSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALLOFTHEABYSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

