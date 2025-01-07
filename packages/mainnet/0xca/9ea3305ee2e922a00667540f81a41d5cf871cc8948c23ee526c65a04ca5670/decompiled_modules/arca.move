module 0xca9ea3305ee2e922a00667540f81a41d5cf871cc8948c23ee526c65a04ca5670::arca {
    struct ARCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCA>(arg0, 9, b"ARCA", b"2CARS", x"416e206f75747374616e64696e67206175746f6d6f74697665207468656d6564206272616e6420746861742063617074757265732074686520657373656e6365206f662073706565642c20696e6e6f766174696f6e20616e6420656c6567616e63650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ab1dede-5967-4cb2-b480-df643aee7d69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

