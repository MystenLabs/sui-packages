module 0x946f57e6c5208b53965b49ece48a80e2f302d61aa8c13bc5839e5868821925c3::chimpie {
    struct CHIMPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIMPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIMPIE>(arg0, 6, b"CHIMPIE", b"Chimpie", b"Chimpie, the cheeky blue monkey, swings through the jungle with a sparkle in his eye and a knack for hilarious mischief!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_35_ec6a9ae131.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIMPIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIMPIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

