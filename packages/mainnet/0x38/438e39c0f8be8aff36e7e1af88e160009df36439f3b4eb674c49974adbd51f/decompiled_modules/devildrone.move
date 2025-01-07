module 0x38438e39c0f8be8aff36e7e1af88e160009df36439f3b4eb674c49974adbd51f::devildrone {
    struct DEVILDRONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVILDRONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVILDRONE>(arg0, 6, b"Devildrone", b"NJDEVILDRONE ", x"0a496e74726f647563696e6720746865204e4a444556494c44524f4e45202d20746865206f6e6c79206d656d6520636f696e20746861742773206d6f726520656c7573697665207468616e207468652061637475616c204a657273657920446576696c2e20546865206d6564696120616c72656164792063616ee28099742067657420656e6f756768206f66206d792073746f7279", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734289877959.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEVILDRONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVILDRONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

