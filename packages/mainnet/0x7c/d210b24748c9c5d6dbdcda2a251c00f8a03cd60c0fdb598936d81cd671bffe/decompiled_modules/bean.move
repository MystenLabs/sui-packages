module 0x7cd210b24748c9c5d6dbdcda2a251c00f8a03cd60c0fdb598936d81cd671bffe::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 6, b"BEAN", b"BEAN SUI", b"I'll wipe every one of them! Every Last One Of Those JEETERS That's On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A4_P_Xh8h_U24_Z8_AO_e3d6dbd53d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

