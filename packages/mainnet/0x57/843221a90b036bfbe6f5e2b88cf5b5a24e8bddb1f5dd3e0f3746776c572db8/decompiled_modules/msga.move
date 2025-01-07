module 0x57843221a90b036bfbe6f5e2b88cf5b5a24e8bddb1f5dd3e0f3746776c572db8::msga {
    struct MSGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGA>(arg0, 6, b"MSGA", b"Make Sui Great Again", b"Sui Maga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1730836793_273323_33_EA_8_B70_CAEB_4529_BD_9_D_A8_F6072_FDD_0_E_c5206a37e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

