module 0xe000256d54c27852a723cf057416e1f81ced857991258df881ad96161f45471b::lioncat {
    struct LIONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIONCAT>(arg0, 6, b"LIONCAT", b"LionCat", b"Meet $LionCat, the crypto sensation thats roaring with cuteness and prowling the blockchain like a boss! This cats got more swagger than a lion in a tutu. Get ready to LOL your way to financial greatness with the fluffiest currency in town!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725684106586_5850f99780f85499b4f2bc66bef5fa89_455d00ae63.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

