module 0x9bf57e8824f1926b86df3d979e97a175da32f76ea937e25e1fcd40936a35060c::feel {
    struct FEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEEL>(arg0, 9, b"feel", b"pio", b"sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FEEL>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

