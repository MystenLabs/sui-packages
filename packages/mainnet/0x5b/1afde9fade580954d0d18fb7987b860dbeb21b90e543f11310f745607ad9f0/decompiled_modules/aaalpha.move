module 0x5b1afde9fade580954d0d18fb7987b860dbeb21b90e543f11310f745607ad9f0::aaalpha {
    struct AAALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAALPHA>(arg0, 6, b"AAALPHA", b"AAA PHA", b"Awooo! Did you hear that? It's the howl of the AAApha wolf! The meme that's here to dominate the Sui Network. When the alpha speaks, the market listens! Want to join the pack? Then howl along and hold tight, because AAApha is coming in strong! Awooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000245667_5754428f91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

