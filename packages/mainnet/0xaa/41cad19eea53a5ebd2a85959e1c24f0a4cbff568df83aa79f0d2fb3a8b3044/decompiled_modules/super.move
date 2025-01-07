module 0xaa41cad19eea53a5ebd2a85959e1c24f0a4cbff568df83aa79f0d2fb3a8b3044::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 6, b"SUPER", b"SUPER on Super", x"546865207265616c206865726f20696e2074686520537569206e6574776f726b2e202453555045520a0a245355504552204953205355504552", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fdggsgrs_a2347dc836.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

