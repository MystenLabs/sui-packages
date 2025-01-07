module 0x10759824cf01f51e00177a98ecff9a20562236cdf183432ac94dfc84180a96b2::suimeh {
    struct SUIMEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEH>(arg0, 6, b"SUIMEH", b"MEH ON SUI", x"245355494d454820e280942074686520656d626f64696d656e74206f662061706174687920696e20746865206d656d6520636f696e20756e6976657273652c2074686520756c74696d6174652063727970746f20646567656e2c20656d6f74696f6e6c65737320696e207468652066616365206f66206368616f732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989018131.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

