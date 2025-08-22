module 0xec8e1f9a0a8fa1c44cdc91fbb0697922851057f3902be1faee276caabfeffc6a::san {
    struct SAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAN>(arg0, 9, b"SAN", b"JOHN", b"JOHN SAN TAK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAN>>(v2, @0x191726a4470b439a8353879cbcb7a67617e78ef938eb3b8cd5a0cf1cf285ce8f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

