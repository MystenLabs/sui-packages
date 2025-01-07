module 0xddd705d244ca3bb6b08bc79cdc03008e9aecad57badad0cf792b9175b7bccff8::xuvvas {
    struct XUVVAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUVVAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUVVAS>(arg0, 9, b"XUVVAS", b"Gama", b"Dan baiwa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/577f542d-37b6-41d1-8bd3-6204c182c77c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUVVAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUVVAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

