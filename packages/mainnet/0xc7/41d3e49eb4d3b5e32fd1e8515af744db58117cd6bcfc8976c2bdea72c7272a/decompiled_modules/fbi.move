module 0xc741d3e49eb4d3b5e32fd1e8515af744db58117cd6bcfc8976c2bdea72c7272a::fbi {
    struct FBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBI>(arg0, 9, b"FBI", b"FBI", b"FBI coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FBI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

