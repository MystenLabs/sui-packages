module 0x6840670ecfa6e29dcc343755797e6ab47781eed953eb954aca23035ea053e387::dew {
    struct DEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEW>(arg0, 6, b"DEW", b"Dew", x"4445570a0a44796e616d69632045786368616e67652057616c6c65740a0a43726f737320436861696e2050726f746f636f6c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736055334309.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

