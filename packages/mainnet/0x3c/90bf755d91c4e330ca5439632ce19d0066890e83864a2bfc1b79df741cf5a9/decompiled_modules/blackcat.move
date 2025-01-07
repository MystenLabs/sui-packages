module 0x3c90bf755d91c4e330ca5439632ce19d0066890e83864a2bfc1b79df741cf5a9::blackcat {
    struct BLACKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKCAT>(arg0, 6, b"Blackcat", b"Black cat on sui", b"Black cat on sui is a great memecoin on sui , buy black cat meme now .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_1ba7a5c356.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

