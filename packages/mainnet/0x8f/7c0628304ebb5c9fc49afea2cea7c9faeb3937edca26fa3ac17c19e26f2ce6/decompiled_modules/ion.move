module 0x8f7c0628304ebb5c9fc49afea2cea7c9faeb3937edca26fa3ac17c19e26f2ce6::ion {
    struct ION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ION>(arg0, 6, b"ION", b"ION", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $ION + ION https://t.co/HMj5QMFXD8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ion-925vse.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ION>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ION>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

