module 0xc416661f39d851e7a58615badfb89c10bb57f81e6818a3a9992f8c2a6709085c::suidon {
    struct SUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDON>(arg0, 6, b"SUIDON", b"POSUIDON", b"First god of the sea on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_9b4161c398.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

