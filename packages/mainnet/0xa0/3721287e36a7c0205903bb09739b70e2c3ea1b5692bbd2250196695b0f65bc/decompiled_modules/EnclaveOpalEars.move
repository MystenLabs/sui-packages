module 0xa03721287e36a7c0205903bb09739b70e2c3ea1b5692bbd2250196695b0f65bc::EnclaveOpalEars {
    struct ENCLAVEOPALEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENCLAVEOPALEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENCLAVEOPALEARS>(arg0, 0, b"COS", b"Enclave Opal Ears", b"Place your ear to the dirt-scrabbled floor... listen...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Enclave_Opal_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENCLAVEOPALEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENCLAVEOPALEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

