module 0xbef31a255bf77f3ba5dbf548e8929ab2feae40c676423488519609869e9557c9::milo {
    struct MILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILO>(arg0, 6, b"MILO", b"Milo The Dino", b"gm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreialgjj2h4bvgwd5m25dpkxd52uncdxxdklfanmrsvx4nqrs2ugrwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MILO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

