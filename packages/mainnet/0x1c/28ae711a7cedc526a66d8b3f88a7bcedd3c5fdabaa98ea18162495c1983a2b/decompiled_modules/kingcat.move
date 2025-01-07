module 0x1c28ae711a7cedc526a66d8b3f88a7bcedd3c5fdabaa98ea18162495c1983a2b::kingcat {
    struct KINGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGCAT>(arg0, 6, b"KingCat", b"KingCat Sui", b"No meme does it like the BOSS cat. Hell show the dogs and other cats what makes a great meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xf51bee141c9551338d1b26844ae5035b55993f0d_442ac26dca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

