module 0x33d205758b2367117dc5b8f8f9090ef733376fb4ce0a66055f6a620704b9fdca::TheCorruptionWithin {
    struct THECORRUPTIONWITHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: THECORRUPTIONWITHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THECORRUPTIONWITHIN>(arg0, 0, b"COS", b"The Corruption Within", b"How it spreads... the great undoing... where do we go from nowhere?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_The_Corruption_Within.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THECORRUPTIONWITHIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THECORRUPTIONWITHIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

