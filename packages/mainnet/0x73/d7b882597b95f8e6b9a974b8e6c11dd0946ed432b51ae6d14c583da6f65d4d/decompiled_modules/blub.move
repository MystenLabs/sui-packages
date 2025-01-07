module 0x73d7b882597b95f8e6b9a974b8e6c11dd0946ed432b51ae6d14c583da6f65d4d::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"BLUB SUI", b"$BLUB is the funniest and most degenerate fish in the Sui Ocean, staying true to its origins and bringing the chaotic energy of the 'Boy's Club'the creators of $PEPEto the Sui Network. With its dirty and clumsy manner, $BLUB causes real chaos in the coral. It brings a unique theme and perfect synergy with the Sui Network, making it an irresistible crypto for those who love memes and aspire to conquer oceans and achieve dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X3y_Nj_Er_CMEQ_Bn_Z8_L2_Xd8y_AZYG_7n_WA_9_M6_Aw1_TT_1zh_Pe_SP_1_f3cf430be2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

