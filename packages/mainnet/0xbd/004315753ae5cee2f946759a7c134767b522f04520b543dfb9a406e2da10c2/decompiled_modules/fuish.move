module 0xbd004315753ae5cee2f946759a7c134767b522f04520b543dfb9a406e2da10c2::fuish {
    struct FUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUISH>(arg0, 6, b"FUISH", b"SUI FUISH", x"4a7573742061206669736820696e2074686520537569204f6365616e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Ed2_UHNL_400x400_dfc47b07a0_0879885368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

