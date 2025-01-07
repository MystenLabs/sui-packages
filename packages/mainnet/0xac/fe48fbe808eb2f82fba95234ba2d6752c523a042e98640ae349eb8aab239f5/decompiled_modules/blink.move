module 0xacfe48fbe808eb2f82fba95234ba2d6752c523a042e98640ae349eb8aab239f5::blink {
    struct BLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINK>(arg0, 6, b"BLINK", b"Blink", x"57686572652049732054686520486967686573742050756d702046756e3f205269676e7420486572652120424c494e4b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SG_9_H1_W7muf64_Stcevw_Y_Yjd2hr8p_Ac_Ct_Ne9ewf_Vn_Cxo_BW_debaac8890.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

