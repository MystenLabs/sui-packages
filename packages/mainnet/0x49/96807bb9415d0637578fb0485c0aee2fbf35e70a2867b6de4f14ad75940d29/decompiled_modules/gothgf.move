module 0x4996807bb9415d0637578fb0485c0aee2fbf35e70a2867b6de4f14ad75940d29::gothgf {
    struct GOTHGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTHGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTHGF>(arg0, 6, b"GOTHGF", b"BigTitty GothGF", b"Everyone needs them a Big Titty Goth Girlfriend | $GOTHGF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wq_Cs_AG_Dembnrt16_M_Pi5_Wv_Npo_E_Zn_Fg_Hjfcw9wv7_XZ_Er_Jh_e48ab9649c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTHGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOTHGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

