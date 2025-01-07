module 0x5bffce60f2c081efabd0e9afc4ffeb9a5f12cf83a32bcb68c32f90a56e29cf24::sya {
    struct SYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYA>(arg0, 9, b"SYA", b"SYA", b"SYA", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SYA>(&mut v2, 12414212000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

