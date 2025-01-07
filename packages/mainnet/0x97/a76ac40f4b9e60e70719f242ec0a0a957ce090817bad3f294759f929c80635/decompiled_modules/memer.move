module 0x97a76ac40f4b9e60e70719f242ec0a0a957ce090817bad3f294759f929c80635::memer {
    struct MEMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMER>(arg0, 6, b"Memer", b"memer ", x"206a757374206578706572696d656e74696e672e204e6f206578706563746174696f6e73e28094697420636f756c64207475726e206f757420746f20626520736f6d657468696e67206f72206e6f7468696e672e20f09f9180", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731034287286.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

