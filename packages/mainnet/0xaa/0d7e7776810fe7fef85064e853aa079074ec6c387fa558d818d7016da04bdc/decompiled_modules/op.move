module 0xaa0d7e7776810fe7fef85064e853aa079074ec6c387fa558d818d7016da04bdc::op {
    struct OP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OP>(arg0, 9, b"OP", b"OPIUM", b"OPIUM GANG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OP>>(v1);
    }

    // decompiled from Move bytecode v6
}

