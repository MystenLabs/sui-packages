module 0x84ef9d9bf47b39bc248f2b18cccdbf5aac40dd7b7b8aac2f07eabccdc2a6258c::osiriii {
    struct OSIRIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSIRIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSIRIII>(arg0, 9, b"OSIRIII", b"OSIRII", b"S", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OSIRIII>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSIRIII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSIRIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

