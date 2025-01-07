module 0xaa89dc4058c0420dc7af415b8c6822f3afed50eb9e5cd593a5305a59e88aa2d5::AGuiseofRecognition {
    struct AGUISEOFRECOGNITION has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGUISEOFRECOGNITION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGUISEOFRECOGNITION>(arg0, 0, b"COS", b"A Guise of Recognition", b"Tear away the mask... reveal the absence within... the vile absence...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_A_Guise_of_Recognition.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGUISEOFRECOGNITION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGUISEOFRECOGNITION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

