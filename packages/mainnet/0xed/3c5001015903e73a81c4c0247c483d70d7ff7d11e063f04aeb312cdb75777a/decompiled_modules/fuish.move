module 0xed3c5001015903e73a81c4c0247c483d70d7ff7d11e063f04aeb312cdb75777a::fuish {
    struct FUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUISH>(arg0, 6, b"FUISH", b"FUISHUI", b"Just a fish in the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Ed2_UHNL_400x400_8067bb4b4b_043117636f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

