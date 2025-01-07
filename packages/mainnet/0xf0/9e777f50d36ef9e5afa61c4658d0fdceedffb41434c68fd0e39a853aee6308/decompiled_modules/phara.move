module 0xf09e777f50d36ef9e5afa61c4658d0fdceedffb41434c68fd0e39a853aee6308::phara {
    struct PHARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHARA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PHARA>(arg0, 6, b"PHARA", b"Paraoh by SuiAI", x"497427732074696d6520746f206272696e67206261636b2074686520616e6369656e742070686172616f6e69632073706972697420746f2074686520776174657220636861696e20f09f92a720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pharaoh_mini_c8a678f1c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PHARA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHARA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

