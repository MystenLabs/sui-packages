module 0x20917643ac674e260a52e4a6962d2454c622f54640e7ae9b73484dd10a7009cc::suimew {
    struct SUIMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEW>(arg0, 6, b"SUIMEW", b"Suimew Pokemon", b"$SUIMEW building first pokemon game P2E on @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigw7looanwlxfs2qphfp6odfja7opfk5m4264zgqd34rxahr3vh5q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMEW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

