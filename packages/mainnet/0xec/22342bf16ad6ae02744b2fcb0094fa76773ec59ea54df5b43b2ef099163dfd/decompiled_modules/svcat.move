module 0xec22342bf16ad6ae02744b2fcb0094fa76773ec59ea54df5b43b2ef099163dfd::svcat {
    struct SVCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVCAT>(arg0, 6, b"Svcat", b"suiv cat", b"The best cat meme coin on sui network, buy svcat , we will pump and pump .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_ragdoll_cat_dcb33158cc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

