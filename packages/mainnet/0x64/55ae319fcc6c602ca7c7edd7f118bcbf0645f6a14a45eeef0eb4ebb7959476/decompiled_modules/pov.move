module 0x6455ae319fcc6c602ca7c7edd7f118bcbf0645f6a14a45eeef0eb4ebb7959476::pov {
    struct POV has drop {
        dummy_field: bool,
    }

    fun init(arg0: POV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POV>(arg0, 6, b"Pov", b"Pioneer Of Vibe ", x"5649424520434845434b21200a0a496e74726f647563696e672024504f563a2050696f6e65657273204f6620566962652c2074686520756c74696d617465206d656d6520746f6b656e206f6e20535549204e6574776f726b21200a0a2024504f56206973206d6f7265207468616e206a757374206120746f6b656e202d20697427732061206d6f76656d656e742e205765277265206275696c64696e67206120636f6d6d756e69747920746861742063656c6562726174657320637265617469766974792c20706f73697469766974792c20616e6420626c6f636b636861696e20696e6e6f766174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749436011426.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

