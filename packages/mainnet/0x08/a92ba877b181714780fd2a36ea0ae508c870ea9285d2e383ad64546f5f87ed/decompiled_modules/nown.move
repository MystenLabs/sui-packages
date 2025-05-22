module 0x8a92ba877b181714780fd2a36ea0ae508c870ea9285d2e383ad64546f5f87ed::nown {
    struct NOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOWN>(arg0, 6, b"NOWN", b"POKENOWN", b"Spelling Mistakes, on Purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih4maraz7f7ito2jsivuic5cnokvzkhdigmzeg73hqqjhqdxix3ce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOWN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

