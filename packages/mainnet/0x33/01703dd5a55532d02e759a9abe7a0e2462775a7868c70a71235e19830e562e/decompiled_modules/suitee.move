module 0x3301703dd5a55532d02e759a9abe7a0e2462775a7868c70a71235e19830e562e::suitee {
    struct SUITEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEE>(arg0, 6, b"SUITEE", b"Suitee", b"Suitee is a cute, fun-loving seal who wants to share SUI with the whole world. She just needs a little help from her community to make it happen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_EBEE_93_A_E6_DC_464_D_96_AB_0_EAE_40_C301_C0_eb59c24986.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

