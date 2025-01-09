module 0xff516076be51effc78ea6b5ae94f850bbc8cc859377740d9ec28124da4862a09::aixbt {
    struct AIXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIXBT>(arg0, 9, b"AIXBT", b"aixbt", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1874758416658509824/UPaVddbm_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIXBT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIXBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXBT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

