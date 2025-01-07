module 0xbe6468e7771daa931bf7a96d010956bd3f521dcec51dc2234026a838f22dde8b::icat {
    struct ICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICAT>(arg0, 6, b"ICat", b"Intern Cat", b"This kitten looks like a customer service worker and is an internet sensation in TIKTOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e7ae0b5acce9a828a63b05d6c404b5b_40a45807a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

