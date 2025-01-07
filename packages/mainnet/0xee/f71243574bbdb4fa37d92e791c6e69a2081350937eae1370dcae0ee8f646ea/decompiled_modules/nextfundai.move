module 0xeef71243574bbdb4fa37d92e791c6e69a2081350937eae1370dcae0ee8f646ea::nextfundai {
    struct NEXTFUNDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXTFUNDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXTFUNDAI>(arg0, 6, b"NEXTFUNDAI", b"The NexFundAI by FBI", b"NEXTFUNDAI powered by FBI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yw1q_QQ_8_Y1o1_Q_Md4bin_Gzy_Dxgw_Q_Zfr_KA_Tgv_NS_2azpump_3cf2195750.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXTFUNDAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEXTFUNDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

