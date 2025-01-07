module 0x38d66e9ff1e0f119f058369c918cad45760a7d439598b6cc234c05bdcbea84b6::EarsoftheEnclaveFervor {
    struct EARSOFTHEENCLAVEFERVOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARSOFTHEENCLAVEFERVOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARSOFTHEENCLAVEFERVOR>(arg0, 0, b"COS", b"Ears of the Enclave Fervor", b"Sound clings to you as static... Will the Sound appear to you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ears_of_the_Enclave_Fervor.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARSOFTHEENCLAVEFERVOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARSOFTHEENCLAVEFERVOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

