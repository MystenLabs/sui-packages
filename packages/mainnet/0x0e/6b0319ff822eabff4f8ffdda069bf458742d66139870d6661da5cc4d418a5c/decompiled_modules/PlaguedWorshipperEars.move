module 0xe6b0319ff822eabff4f8ffdda069bf458742d66139870d6661da5cc4d418a5c::PlaguedWorshipperEars {
    struct PLAGUEDWORSHIPPEREARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAGUEDWORSHIPPEREARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAGUEDWORSHIPPEREARS>(arg0, 0, b"COS", b"Plagued Worshipper Ears", b"Why has it come for me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Plagued_Worshipper_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLAGUEDWORSHIPPEREARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAGUEDWORSHIPPEREARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

