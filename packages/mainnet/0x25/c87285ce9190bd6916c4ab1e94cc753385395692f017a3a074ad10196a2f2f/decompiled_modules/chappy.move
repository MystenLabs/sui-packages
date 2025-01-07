module 0x25c87285ce9190bd6916c4ab1e94cc753385395692f017a3a074ad10196a2f2f::chappy {
    struct CHAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAPPY>(arg0, 6, b"Chappy", b"Chappy Trump", x"446f6e616c64207472756d707320646f67204368617070790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmce5_Q_Rb_AH_5jw_Cx_Ds_Vi_Pn_FJVHAE_1_YK_Hwfuw_KH_Cng_Eu_RU_Ut_3ba307fa68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

