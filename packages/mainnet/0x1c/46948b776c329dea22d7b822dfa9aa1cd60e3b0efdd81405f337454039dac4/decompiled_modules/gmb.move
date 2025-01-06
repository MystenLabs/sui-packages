module 0x1c46948b776c329dea22d7b822dfa9aa1cd60e3b0efdd81405f337454039dac4::gmb {
    struct GMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMB>(arg0, 6, b"GMB", b"Gumboll", x"24474d422077696c6c20626520746865202331204d656d65206f6e2053756920616e642074686520756c74696d6174652063686f69636520666f722074686f7365207365656b696e67202450455045206f6e2074686520537569206e6574776f726b2e0a496620796f75277265206c6f6f6b696e6720746f20676f20626967206f6e2061207472756520626c75656368697020616e642067657420696e206561726c79206f6e20612066757475726520746f702031303020776974682061206d6f64657374206d61726b6574636170", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736166863653.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

