module 0xdc9ef2cdf2b32e2be38b87f6812cd2b53c9cad4ce5ab652bb56942c89170f8e9::steven {
    struct STEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEVEN>(arg0, 9, b"STEVEN", b"Steven Universe", b"Steven Universe Token is a meme token inspired by the themes of love, friendship, and adventure from the Steven Universe series. Just like Steven and the Crystal Gems who protect Earth, STEVE is here to create a vibrant, inclusive, and innovative community while delivering a fun and rewarding blockchain experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX8bMiajK5sZpsnrwZoXaZWYPeQuZksHeCdpNuXazoC1v")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEVEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEVEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEVEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

