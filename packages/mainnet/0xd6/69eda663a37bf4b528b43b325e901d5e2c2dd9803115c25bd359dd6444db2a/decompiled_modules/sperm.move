module 0xd669eda663a37bf4b528b43b325e901d5e2c2dd9803115c25bd359dd6444db2a::sperm {
    struct SPERM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPERM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPERM>(arg0, 6, b"SPERM", b"SUPERM", b"a sex cell produced by a man or male animal: In human reproduction, one female egg is usually fertilized by one sperm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GU_On_M0_BXUAEE_Ysl_5f8079ff13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPERM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPERM>>(v1);
    }

    // decompiled from Move bytecode v6
}

