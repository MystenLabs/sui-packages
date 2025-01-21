module 0xe885434cf9714a635bd31b3c822fd67b31077dfe6d23da6be59c071462f3ae07::ivanka {
    struct IVANKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVANKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVANKA>(arg0, 9, b"IVANKA", b"IVANKA TRUMP", b"The Only Official Ivanka Trump SOL Meme. $IVANKA ( Trump's daughter )", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbTEkMahBxaK98FmAHWywjgNc8bR232LHfh7mhUyZnhbL")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IVANKA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVANKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVANKA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

