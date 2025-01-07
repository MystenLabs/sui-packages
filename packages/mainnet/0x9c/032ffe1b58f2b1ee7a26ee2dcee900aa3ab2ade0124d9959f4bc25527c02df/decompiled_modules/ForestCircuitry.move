module 0x9c032ffe1b58f2b1ee7a26ee2dcee900aa3ab2ade0124d9959f4bc25527c02df::ForestCircuitry {
    struct FORESTCIRCUITRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORESTCIRCUITRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORESTCIRCUITRY>(arg0, 0, b"COS", b"Forest Circuitry", b"Overgrown with the memory of light... of divinity...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Forest_Circuitry.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORESTCIRCUITRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORESTCIRCUITRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

