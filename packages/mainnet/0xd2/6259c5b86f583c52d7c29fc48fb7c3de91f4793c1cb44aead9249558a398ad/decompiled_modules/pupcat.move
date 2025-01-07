module 0xd26259c5b86f583c52d7c29fc48fb7c3de91f4793c1cb44aead9249558a398ad::pupcat {
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

