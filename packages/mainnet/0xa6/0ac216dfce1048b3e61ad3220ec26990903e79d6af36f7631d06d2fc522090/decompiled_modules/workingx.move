module 0xa60ac216dfce1048b3e61ad3220ec26990903e79d6af36f7631d06d2fc522090::workingx {
    struct WORKINGX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WORKINGX>, arg1: 0x2::coin::Coin<WORKINGX>) {
        0x2::coin::burn<WORKINGX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WORKINGX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WORKINGX>>(0x2::coin::mint<WORKINGX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WORKINGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORKINGX>(arg0, 9, b"workingx", b"WORKINGX", b"test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WORKINGX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORKINGX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

