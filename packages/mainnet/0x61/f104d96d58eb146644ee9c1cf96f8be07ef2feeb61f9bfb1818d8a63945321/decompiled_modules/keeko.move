module 0x61f104d96d58eb146644ee9c1cf96f8be07ef2feeb61f9bfb1818d8a63945321::keeko {
    struct KEEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEEKO>(arg0, 9, b"KEEKO", b"Keeko The Frog", b"Keeko has over 50 millions views on tiktok!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmQRg9wAFLXN4X2UmcvF6iQ1eCw85rSaki8ehsvYdZgmaP?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEEKO>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEEKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

