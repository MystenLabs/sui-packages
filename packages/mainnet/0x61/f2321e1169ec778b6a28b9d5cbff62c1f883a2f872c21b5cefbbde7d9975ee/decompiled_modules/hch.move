module 0x61f2321e1169ec778b6a28b9d5cbff62c1f883a2f872c21b5cefbbde7d9975ee::hch {
    struct HCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCH>(arg0, 6, b"HCH", b"HappyChildhoodCoin", b"HCH Token - is a POLYGON project with its own NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722864828571_8f62aabd0953dcb8d843510094339f33_8acead1851.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

