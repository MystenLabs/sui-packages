module 0xa5e30974d1778cd3af93808d2b6dacbebdd680744377e9dab71d15b0cdef6449::test4 {
    struct TEST4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEST4>(arg0, 6, b"TEST4", b"TEST4", b"TEST4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUAI_logo_41f92e4600.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST4>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST4>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

