module 0x13f41b857aba9c4f3751eac4eae8f6ae73c7e276a3f54605c0611d8c0ebd4046::mery {
    struct MERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERY>(arg0, 9, b"MERY", b"Mistery", b"MERY MERY THE CROFAM! Mistery is a thing that you cannot understand! The thing that we are all looking for! It has now appeared on CRONOSCHAIN! A place for people to heal with good laughs and a happy life! A place to share about IRL! A place to be find friends and be unique on web3! This is MERYFAM! As founder, I will bring as much utilities to this token and make it become the most successful token on #cronoschain! 420,690,271,888 420 ALL TIME HIGH 690 KEEP GOING 271 CRO TO $2.71 888 Lucky! Wish you all the best!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/cronos/0x3b41b27e74dd366ce27cb389dc7877d4e1516d4d.png?size=lg&key=0f0216")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MERY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

