module 0x74734385b96391e02cc37bdcc669267eba3a360529e1367be4e3b4d361a78e77::bugcat {
    struct BUGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGCAT>(arg0, 6, b"BUGCAT", b"BugCat Sui", b"BugCat is not just another meme coin; it's a community-driven token designed to embody the playful and mischievous spirit of BugCat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/46r_Lz_Ms_C_400x400_b5aab6db7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

