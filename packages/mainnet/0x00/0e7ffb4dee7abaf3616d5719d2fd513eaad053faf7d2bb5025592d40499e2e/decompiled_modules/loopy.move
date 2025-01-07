module 0xe7ffb4dee7abaf3616d5719d2fd513eaad053faf7d2bb5025592d40499e2e::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 9, b"LOOPY", b"LOOPY", b"LOOPY MAKE GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x9b9c0e26a8ace7edb8fce14acd81507c507c677a400cfb9cc9a0ca4a8432a97a::loopy_sui::loopy_sui.png?size=lg&key=3199de")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOOPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

