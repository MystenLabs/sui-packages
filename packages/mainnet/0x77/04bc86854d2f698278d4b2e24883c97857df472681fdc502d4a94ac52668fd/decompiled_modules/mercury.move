module 0x7704bc86854d2f698278d4b2e24883c97857df472681fdc502d4a94ac52668fd::mercury {
    struct MERCURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCURY>(arg0, 6, b"MERCURY", b"Mercury", b"The planets of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fjbee_Ri_PR_Qj_Q_Nhizwy7c_WX_1200_80_82897c5593.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCURY>>(v1);
    }

    // decompiled from Move bytecode v6
}

