module 0x5e3e62f746ea48c989fd2650bbcfbd9323cda141e948d33ae6b86b83fe553ef1::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"MYCOIN", b"My Coin", b"something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreifhn6kn2rsvjztb6lgfhatkt4ottwzavzjelw6wnu5zxws67szvgm.ipfs.nftstorage.link/"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::coin::mint_and_transfer<MYCOIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MYCOIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

