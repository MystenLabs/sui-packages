module 0x7cf06b68f96cd87b3e6426a6374885cfc2ba694a528b1806f2cf92069c30fbb6::jolie {
    struct JOLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLIE>(arg0, 6, b"JOLIE", b"Joliebee", b"Come here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750926904464.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOLIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

