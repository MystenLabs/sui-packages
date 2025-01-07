module 0x69f3d0ce1fcfbbcd275c5178343e0ac7f37dde512b0f10d2a69c7ce936f5deed::suivan {
    struct SUIVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVAN>(arg0, 6, b"SUIVAN", b"Sui Robovan", b"The future is autonomous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/robovan_d97fc3d784.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

