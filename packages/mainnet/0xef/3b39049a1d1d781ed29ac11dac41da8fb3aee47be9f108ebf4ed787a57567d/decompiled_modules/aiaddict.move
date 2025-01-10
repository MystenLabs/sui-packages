module 0xef3b39049a1d1d781ed29ac11dac41da8fb3aee47be9f108ebf4ed787a57567d::aiaddict {
    struct AIADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIADDICT>(arg0, 6, b"AIADDICT", b"Addict_Agent - AI_ADDICT by SuiAI", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. Constantly evolving and building. Join or eat dirt, lad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1_Dq_HI_Jze_400x400_aebc32f3fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIADDICT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIADDICT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

