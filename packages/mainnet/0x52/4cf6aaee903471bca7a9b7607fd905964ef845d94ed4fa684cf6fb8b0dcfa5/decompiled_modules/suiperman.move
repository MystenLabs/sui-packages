module 0x524cf6aaee903471bca7a9b7607fd905964ef845d94ed4fa684cf6fb8b0dcfa5::suiperman {
    struct SUIPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERMAN>(arg0, 6, b"SUIPERMAN", b"SUIPERMAN HAS CUM", b"Only the women can be pump! $SUIPERMAN gonna make you cuuuuuumm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibudi6mxkmgfsi6oac7bt2tfrcwcng4ich24457oib47rdgd5ksua")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIPERMAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

