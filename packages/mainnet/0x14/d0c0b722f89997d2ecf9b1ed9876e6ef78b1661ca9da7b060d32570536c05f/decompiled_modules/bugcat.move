module 0x14d0c0b722f89997d2ecf9b1ed9876e6ef78b1661ca9da7b060d32570536c05f::bugcat {
    struct BUGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGCAT>(arg0, 6, b"BUGCAT", b"Sui Bugcat", b"$BugCat is not just another meme coin; it's a community-driven token designed to embody the playful and mischievous spirit of BugCat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250106_232336_572_4f476af464.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

