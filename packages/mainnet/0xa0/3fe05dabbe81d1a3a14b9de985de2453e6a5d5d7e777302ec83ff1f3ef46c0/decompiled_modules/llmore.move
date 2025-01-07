module 0xa03fe05dabbe81d1a3a14b9de985de2453e6a5d5d7e777302ec83ff1f3ef46c0::llmore {
    struct LLMORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLMORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLMORE>(arg0, 9, b"LLMORE", b"LOVEMORE", b"GOOD LOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LLMORE>(&mut v2, 40000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLMORE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLMORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

