module 0x2e2cbeef7bc1255d01723e21359774a915f6dfdf4aea5ad2e9b5b467a7847bdf::amero {
    struct AMERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMERO>(arg0, 9, b"AMERO", b"Amero meme", x"496e74726f647563696e6720414d45524f2c207468650a6d656d6520636f696e207468617420726569676e730a73757072656d65212041732074686520677261792063617264696e616c0a6f66206d656d6520636f696e7320656d65726765732066726f6d0a74686520736861646f77732c207072657061726520746f20626f770a6265666f726520746865206c6f7264206f66206d656d65732e0a416d65726f3a207768657265206d656d6573206d6565740a6d6f6e657920616e64206c6567656e6473206172650a6d696e74656421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbe6c61f-7427-41e3-903f-98e7bd6a34d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

