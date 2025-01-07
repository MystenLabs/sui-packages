module 0xd74e84c96453b70710ed431e17ffb2b8efe1968313f08038d9224f807c2dcc::aevan {
    struct AEVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEVAN>(arg0, 6, b"AEVAN", b"AquaEvan", x"417175614576616e202d20496e7370697265642062792020404576616e576562332c20546865204c6567656e64617279205365612057617272696f7220616e6420526967687466756c204b696e67206f662054686520537569204b696e67646f6d20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962913003.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AEVAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEVAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

