module 0x1d4f134d1cc56620d58a7a02bb8ee877298fec8f2c7b14b333e58f2914fab73d::iba {
    struct IBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBA>(arg0, 9, b"iba", b"iba", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IBA>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBA>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

