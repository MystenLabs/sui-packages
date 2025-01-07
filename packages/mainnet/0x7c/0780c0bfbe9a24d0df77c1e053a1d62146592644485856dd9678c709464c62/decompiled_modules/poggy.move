module 0x7c0780c0bfbe9a24d0df77c1e053a1d62146592644485856dd9678c709464c62::poggy {
    struct POGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGGY>(arg0, 6, b"POGGY", b"poggy on sui", b"Little Pig, Dream Big!  Poggy is the fast-growing meme community on SUI. A meme coin is for entertainment purposes only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000129550_7a86777243.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

