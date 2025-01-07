module 0xb993661f788c1cb2fbf04515721ffc1d258f6d71bbcd08fa5006ca3e7d356ea1::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"LOFI", b"Lofi The Yeti", x"4120796574692066726f7a656e20696e2074696d652c206177616b656e65642062792074686520537569206c6567656e64732e204a6f696e2074686520244c4f4649206d6f76656d656e743a20687474703a2f2f742e6d652f4c6f66694f6e5375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RIZW_Nf_O_400x400_4860360eee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

