module 0xfa3fa2b54cb9e18cd1f7452e36a86d07a404de9d1715508a9af189b5f0c095b5::mose {
    struct MOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSE>(arg0, 6, b"MOSE", b"MOSE SUI", x"4d4f53452049732074686520456c64657220426c75652046726f672066726f6d20224d696e64766973636f7369747922204865204973207365656e20616d6f6e677374204f746865722063686172616374657273204f686172652c2047726f67676f2c205261696e626f772c2046654665202c205363616c657920616e6420576f6c6620536b756c6c2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N99md_B_Jd_ngzndlu_e543739e28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

