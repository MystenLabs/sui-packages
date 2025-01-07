module 0x482102267b9505643b13c6cf9c997962802c058bca9a240b83998d8f1e13d167::moisx {
    struct MOISX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOISX>, arg1: 0x2::coin::Coin<MOISX>) {
        0x2::coin::burn<MOISX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOISX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOISX>>(0x2::coin::mint<MOISX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOISX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOISX>(arg0, 9, b"Moisx", b"MOISX", b"test moisx", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOISX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOISX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

