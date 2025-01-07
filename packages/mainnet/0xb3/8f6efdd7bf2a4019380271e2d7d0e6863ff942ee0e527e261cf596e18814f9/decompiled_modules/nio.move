module 0xb38f6efdd7bf2a4019380271e2d7d0e6863ff942ee0e527e261cf596e18814f9::nio {
    struct NIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIO>(arg0, 11, b"NIO", b"night owl", b"test tokens", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NIO>(&mut v2, 1900000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

