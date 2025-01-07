module 0xafe4e2c8369a81f6853fb77ef81f5c75895e27eff210a1b03211558bf23d97d5::sz {
    struct SZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZ>(arg0, 6, b"SZ", b"SuiZ", b"SuiZ is free!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GF_Ag_QK_9bs_AAR_dw_31a3411ffd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

