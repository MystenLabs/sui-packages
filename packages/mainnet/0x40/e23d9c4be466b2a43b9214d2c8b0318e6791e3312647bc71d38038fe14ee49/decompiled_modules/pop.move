module 0x40e23d9c4be466b2a43b9214d2c8b0318e6791e3312647bc71d38038fe14ee49::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"PO OP sui", b"POP On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gcs/files/cd28aa87caf2af70b53c1767538edab7.png?auto=format&dpr=1&w=1000")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POP>>(v1);
    }

    // decompiled from Move bytecode v6
}

