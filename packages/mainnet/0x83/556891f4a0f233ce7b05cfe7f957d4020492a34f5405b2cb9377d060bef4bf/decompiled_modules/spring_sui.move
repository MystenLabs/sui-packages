module 0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui {
    struct SPRING_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRING_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRING_SUI>(arg0, 9, b"sSUI", b"Spring SUI", b"Infinitely liquid staking on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suilend-assets.s3.us-east-2.amazonaws.com/lst.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPRING_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRING_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

