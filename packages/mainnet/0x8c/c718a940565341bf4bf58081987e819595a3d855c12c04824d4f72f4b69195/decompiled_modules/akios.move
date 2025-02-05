module 0x8cc718a940565341bf4bf58081987e819595a3d855c12c04824d4f72f4b69195::akios {
    struct AKIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKIOS>(arg0, 6, b"AKIOS", b"SUIAKIO", b"A wonderful Akio dog loves soft things and massages from his parents. Healing his inner peace by relaxing on his vacation is Akio's dream.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/25_4ece40a306.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKIOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

