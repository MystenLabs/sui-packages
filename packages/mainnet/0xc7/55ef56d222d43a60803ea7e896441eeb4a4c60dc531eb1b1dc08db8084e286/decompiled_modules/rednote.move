module 0xc755ef56d222d43a60803ea7e896441eeb4a4c60dc531eb1b1dc08db8084e286::rednote {
    struct REDNOTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDNOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDNOTE>(arg0, 9, b"REDnote", b"Chinese TikTok", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY6EpBUmrkF7XnAQR5k5DRE8qWDFS6q2KrSqXzytnWkfJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REDNOTE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDNOTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDNOTE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

