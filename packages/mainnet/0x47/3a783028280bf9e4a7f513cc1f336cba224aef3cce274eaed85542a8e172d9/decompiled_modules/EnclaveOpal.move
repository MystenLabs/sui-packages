module 0x473a783028280bf9e4a7f513cc1f336cba224aef3cce274eaed85542a8e172d9::EnclaveOpal {
    struct ENCLAVEOPAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENCLAVEOPAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENCLAVEOPAL>(arg0, 0, b"COS", b"Enclave Opal", b"Adrift over placid seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Enclave_Opal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENCLAVEOPAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENCLAVEOPAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

