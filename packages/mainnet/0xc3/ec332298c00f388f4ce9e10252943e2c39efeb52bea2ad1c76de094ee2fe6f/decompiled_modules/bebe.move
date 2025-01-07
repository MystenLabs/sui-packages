module 0xc3ec332298c00f388f4ce9e10252943e2c39efeb52bea2ad1c76de094ee2fe6f::bebe {
    struct BEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBE>(arg0, 6, b"BEBE", b"BEBE THE BLUE FROG", x"426542652049732074686520456c64657220426c75652046726f672066726f6d224d696e64766973636f73697479224865204973207365656e20616d6f6e677374204f746865722063686172616374657273204f686172652c2047726f67676f2c205261696e626f772c2046654665202c205363616c657920616e6420576f6c6620536b756c6c2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_20_08_12_802ddc5eba_3f47820215.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

