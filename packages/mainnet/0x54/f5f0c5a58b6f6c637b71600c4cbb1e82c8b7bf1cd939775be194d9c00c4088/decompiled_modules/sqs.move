module 0x54f5f0c5a58b6f6c637b71600c4cbb1e82c8b7bf1cd939775be194d9c00c4088::sqs {
    struct SQS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQS>(arg0, 6, b"SQS", b"Squide On Sui", b"Squide The Pearl OF SUI, The cryptocurrency market on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aquide_4577ccd99a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQS>>(v1);
    }

    // decompiled from Move bytecode v6
}

