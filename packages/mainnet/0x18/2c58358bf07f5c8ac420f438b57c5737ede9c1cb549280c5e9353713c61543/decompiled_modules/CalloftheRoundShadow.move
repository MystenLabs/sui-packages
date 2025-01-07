module 0x182c58358bf07f5c8ac420f438b57c5737ede9c1cb549280c5e9353713c61543::CalloftheRoundShadow {
    struct CALLOFTHEROUNDSHADOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALLOFTHEROUNDSHADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALLOFTHEROUNDSHADOW>(arg0, 0, b"COS", b"Call of the Round Shadow", b"A voice to pull them away... a whisper to keep them safe...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Call_of_the_Round_Shadow.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CALLOFTHEROUNDSHADOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALLOFTHEROUNDSHADOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

