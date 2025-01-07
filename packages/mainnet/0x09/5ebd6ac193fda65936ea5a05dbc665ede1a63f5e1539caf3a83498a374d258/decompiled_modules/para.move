module 0x95ebd6ac193fda65936ea5a05dbc665ede1a63f5e1539caf3a83498a374d258::para {
    struct PARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARA>(arg0, 6, b"PARA", b"PARAGON SUI", x"50617261676f6e206973205265646566696e696e672057686174277320506f737369626c6520696e2063727970746f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e7843942507f8ba2087d2a0eb8669170_98efe454a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

