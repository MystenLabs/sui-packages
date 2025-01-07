module 0xcde0fe967f9044a66a09ed28090b56cec7e74e328393a4912e7b0f809aa85a71::oof {
    struct OOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOF>(arg0, 6, b"OOF", b"oof", x"77656c636f6d6520746f207468652067726561746573742066696e616e6369616c206f70706f7274756e697479206f66206f75722067656e65726174696f6e20285245414c290a0a68747470733a2f2f6275796f6f662e636f6d0a68747470733a2f2f782e636f6d2f6275796f6f660a68747470733a2f2f742e6d652f6275796f6f660a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732164041883.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

