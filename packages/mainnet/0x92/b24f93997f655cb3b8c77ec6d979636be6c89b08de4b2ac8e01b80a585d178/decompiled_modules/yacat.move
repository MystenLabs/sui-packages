module 0x92b24f93997f655cb3b8c77ec6d979636be6c89b08de4b2ac8e01b80a585d178::yacat {
    struct YACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YACAT>(arg0, 6, b"YACAT", b"YAKUZA CAT", b"JOIN THE YAKUZA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_21_49_23_9a43ce344b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

