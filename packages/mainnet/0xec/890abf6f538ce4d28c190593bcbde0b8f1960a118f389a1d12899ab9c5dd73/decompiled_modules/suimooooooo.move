module 0xec890abf6f538ce4d28c190593bcbde0b8f1960a118f389a1d12899ab9c5dd73::suimooooooo {
    struct SUIMOOOOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOOOOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOOOOOOO>(arg0, 9, b"SUIMOOOOOOO", b"SUI COW Lp", b"SUIMOOO BLUEMOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMOOOOOOO>(&mut v2, 130000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOOOOOOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOOOOOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

