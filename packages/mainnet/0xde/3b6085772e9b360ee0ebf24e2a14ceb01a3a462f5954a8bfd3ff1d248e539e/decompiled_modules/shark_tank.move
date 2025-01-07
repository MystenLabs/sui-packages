module 0xde3b6085772e9b360ee0ebf24e2a14ceb01a3a462f5954a8bfd3ff1d248e539e::shark_tank {
    struct SHARK_TANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK_TANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK_TANK>(arg0, 9, b"SHARK TANK", x"f09fa688536861726b2054616e6b", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHARK_TANK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK_TANK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARK_TANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

