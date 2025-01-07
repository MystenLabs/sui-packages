module 0x96fa417fbf762c46cf5abd48b8308b242f343de8af16d25d4ba2084715eaa371::test1111 {
    struct TEST1111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1111>(arg0, 6, b"TEST1111", b"test111", b"gsdggdgds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shutterstock_2124071366_799c527ed7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST1111>>(v1);
    }

    // decompiled from Move bytecode v6
}

