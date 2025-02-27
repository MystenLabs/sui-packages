module 0xce90ac96069600de8d28f1c3cb78d006bc838863b629bc4237e8b470921c1d12::eva {
    struct EVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVA>(arg0, 9, b"eva", b"eva", b"test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EVA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

