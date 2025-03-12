module 0x3a09f7875bd348dcecf2ed5fb23782bae7e23a3d6f88823dbcc53eaac9b49028::can {
    struct CAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAN>(arg0, 9, b"CAN", b"Can Token", b"A test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

