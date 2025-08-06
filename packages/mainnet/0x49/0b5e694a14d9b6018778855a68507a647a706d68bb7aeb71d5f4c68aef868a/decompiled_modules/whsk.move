module 0x490b5e694a14d9b6018778855a68507a647a706d68bb7aeb71d5f4c68aef868a::whsk {
    struct WHSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHSK>(arg0, 6, b"WHSK", b"WHISKERS", b"Cat, stealth, cuteness, elegance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihb5fl4arn4s3ybkwr6jiwhucrs62bzc2xp2jhysgdd7uc5nrsk6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHSK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

