module 0x30df6c46c0bf8286c0560c22c58fc8c42528de3df09a7961222db0e5e47a93da::look {
    struct LOOK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOOK>, arg1: 0x2::coin::Coin<LOOK>) {
        0x2::coin::burn<LOOK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOOK>>(0x2::coin::mint<LOOK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOK>(arg0, 9, b"LOOK", b"LOOK", b"LOOK PLEASE!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

