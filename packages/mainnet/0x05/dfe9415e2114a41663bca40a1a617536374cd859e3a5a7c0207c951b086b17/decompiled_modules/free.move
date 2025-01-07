module 0x5dfe9415e2114a41663bca40a1a617536374cd859e3a5a7c0207c951b086b17::free {
    struct FREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREE>(arg0, 6, b"FREE", x"f09fa685", x"506f6c796d61726b65742068656c7065642070656f706c6520676f20746f20626564206561726c79206f6e20656c656374696f6e206e696768742c2040656c6f6e6d75736b0a20696e636c756465642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731716455540.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

