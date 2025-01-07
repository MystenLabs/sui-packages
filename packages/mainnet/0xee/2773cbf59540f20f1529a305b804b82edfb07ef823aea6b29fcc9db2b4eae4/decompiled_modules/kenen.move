module 0xee2773cbf59540f20f1529a305b804b82edfb07ef823aea6b29fcc9db2b4eae4::kenen {
    struct KENEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENEN>(arg0, 6, b"KENEN", b"KENEN SUI", b"KENEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qx5e_Zx_S9_400x400_4e2020dfdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

