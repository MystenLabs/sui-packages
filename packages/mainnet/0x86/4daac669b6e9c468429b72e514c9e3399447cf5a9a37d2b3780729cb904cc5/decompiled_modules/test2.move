module 0x864daac669b6e9c468429b72e514c9e3399447cf5a9a37d2b3780729cb904cc5::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 6, b"Test2", b"Test", b"Test3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fx_RWN_JWAA_El_J0_M_888dbf0518.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST2>>(v1);
    }

    // decompiled from Move bytecode v6
}

