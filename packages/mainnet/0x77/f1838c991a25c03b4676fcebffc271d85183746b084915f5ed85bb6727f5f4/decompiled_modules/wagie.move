module 0x77f1838c991a25c03b4676fcebffc271d85183746b084915f5ed85bb6727f5f4::wagie {
    struct WAGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGIE>(arg0, 6, b"WAGIE", b"Wagie on Sui", x"41726520796f75207468652063686f6f7365206f6e6520746f207175697420796f757220392d35202457414749453f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Vmt_XK_Gc_K4_Qn_Bhz42_PE_Ajv_Pt_UHX_93_MNHPPFPYZ_7i_L5_HU_0db73d8a27.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

