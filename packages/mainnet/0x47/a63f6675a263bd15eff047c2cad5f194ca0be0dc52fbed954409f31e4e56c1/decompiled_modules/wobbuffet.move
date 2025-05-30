module 0x47a63f6675a263bd15eff047c2cad5f194ca0be0dc52fbed954409f31e4e56c1::wobbuffet {
    struct WOBBUFFET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOBBUFFET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOBBUFFET>(arg0, 6, b"WOBBUFFET", b"POKEWOB", b"The blue king of bouncebacks is almost here. calm, cool, and about to shake up the meme coin game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigzlb3dvr5u33jn7agmhxt6sqjgi3yiwhstljk3thwfp5hwpqle4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOBBUFFET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOBBUFFET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

