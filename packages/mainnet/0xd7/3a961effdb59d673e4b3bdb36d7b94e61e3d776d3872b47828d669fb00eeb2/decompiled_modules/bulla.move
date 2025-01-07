module 0xd73a961effdb59d673e4b3bdb36d7b94e61e3d776d3872b47828d669fb00eeb2::bulla {
    struct BULLA has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 8, b"BULLA", b"BULLA", b"BULLA-ieve in something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/KimhS4m.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: BULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<BULLA>(arg0, arg1);
        0x2::coin::mint_and_transfer<BULLA>(&mut v0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BULLA>>(v0);
    }

    // decompiled from Move bytecode v6
}

