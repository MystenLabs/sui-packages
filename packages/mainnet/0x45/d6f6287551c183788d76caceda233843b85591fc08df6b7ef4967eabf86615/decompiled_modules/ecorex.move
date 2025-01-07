module 0x45d6f6287551c183788d76caceda233843b85591fc08df6b7ef4967eabf86615::ecorex {
    struct ECOREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECOREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECOREX>(arg0, 6, b"ECOREX", b"ECOREX most environment", x"0a4a6f696e207468652045636f7265782045636f2d467269656e646c79204d6f76656d656e74210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rl_Yf91fq_400x400_f90270c029.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECOREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECOREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

