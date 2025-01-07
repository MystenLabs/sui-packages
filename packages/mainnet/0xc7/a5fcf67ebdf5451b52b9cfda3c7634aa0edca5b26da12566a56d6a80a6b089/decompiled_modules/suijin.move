module 0xc7a5fcf67ebdf5451b52b9cfda3c7634aa0edca5b26da12566a56d6a80a6b089::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"SUIJIN ORB", x"5375696a696e20e6b0b4e7a59e2c2053756974656e20e6b0b4e5a4a92c205375692dc58d20e6b0b4e78e8b0a4465697479206f66207468652057617465722c20746865205365612c20616e642046697368696e6720466f6c6b0a0a436f6c6c656374696e672074686973206f7262732077696c6c2073756d6d6f6e2074686520476f64206f6620576174657220225375696a696e2220636f6c6c656374696f6e7320696e207468652053554920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731025260263.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

