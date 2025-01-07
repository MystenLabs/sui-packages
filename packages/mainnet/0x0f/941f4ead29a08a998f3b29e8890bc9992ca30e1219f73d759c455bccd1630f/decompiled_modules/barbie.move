module 0xf941f4ead29a08a998f3b29e8890bc9992ca30e1219f73d759c455bccd1630f::barbie {
    struct BARBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARBIE>(arg0, 9, b"BARBIE", x"f09f91a9f09f8fbb426172626965", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARBIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARBIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

