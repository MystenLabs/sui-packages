module 0xdf592b58c558cd9fc03a3ad1c97a799c114a8fb1a7f3823e134447e95bb0fa6e::dws {
    struct DWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWS>(arg0, 6, b"DWS", b"DICKWIFSUI", b"DickWifsui aka Dick Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Jc_Zw_QG_Xg_A_Al8_D5_d313f2cf89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

