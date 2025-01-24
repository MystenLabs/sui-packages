module 0x570ca887471fdcb81544f2bd292697c0250c8a2b71e5cc722c8fad53ab579a7f::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 9, b"ACT", b"ACT AI", x"4578706c6f72696e6720656d657267656e74206265686176696f722066726f6d0a6d756c74692d416c2c206d756c74692d68756d616e20696e746572616374696f6e2e204f6666696369616c205820436f6d6d756e697479204163636f756e742e204a6f696e20557321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5a274e4-7e65-49d3-a526-848eab7fce65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

