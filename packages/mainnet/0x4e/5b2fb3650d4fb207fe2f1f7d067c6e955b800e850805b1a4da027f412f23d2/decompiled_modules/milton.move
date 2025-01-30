module 0x4e5b2fb3650d4fb207fe2f1f7d067c6e955b800e850805b1a4da027f412f23d2::milton {
    struct MILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILTON>(arg0, 9, b"MILTON", b"ratomilton", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNZj7LW21ePrQQbeau9zdmegr6SzLfiDDWEH1ZHDuP9Y7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MILTON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILTON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILTON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

