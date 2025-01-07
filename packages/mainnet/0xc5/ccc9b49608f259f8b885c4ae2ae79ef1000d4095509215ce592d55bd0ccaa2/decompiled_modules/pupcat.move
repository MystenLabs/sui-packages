module 0xc5ccc9b49608f259f8b885c4ae2ae79ef1000d4095509215ce592d55bd0ccaa2::pupcat {
    struct PUPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPCAT>(arg0, 6, b"PUPCAT", b"PupCAT", b"PupCat meme coin, white cat on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060672_ebf2b65b82.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

