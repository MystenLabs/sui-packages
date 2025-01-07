module 0xa5cbd1e5d02d992771dd07335715214fa69fd44c6439a884edb5fed57484ea7e::dongcat {
    struct DONGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONGCAT>(arg0, 6, b"DONGCAT", b"DONG CAT", b"DONGCAT meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/76b774a6_e109_4cce_8630_5ea074e4cd9a_c7a11a4c5a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

