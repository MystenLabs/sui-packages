module 0xfe7678534631c4781d1e30bdfdc4f1b41513a1972ae44d4e3bbe089912c2d04e::suibaby {
    struct SUIBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABY>(arg0, 6, b"SUIBABY", b"Sui Baby", x"5375692042616279206973207468652062616279206f662074686520537569206e6574776f726b2c20626f726e20696e20746865206465657020776174657273206f662053756920616e6420726561647920746f2067726f77207374726f6e672e2046726573682066726f6d207468652053756920736561732c2074686973206c6974746c6520677579206861732062696720616d626974696f6e732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_48_f1a0a065cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

