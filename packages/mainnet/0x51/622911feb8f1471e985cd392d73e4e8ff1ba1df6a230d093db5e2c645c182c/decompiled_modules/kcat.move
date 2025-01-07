module 0x51622911feb8f1471e985cd392d73e4e8ff1ba1df6a230d093db5e2c645c182c::kcat {
    struct KCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCAT>(arg0, 6, b"KCAT", b"KawaiiCat", b"Kawaii Cat is a memecoin on the Sui that aims to become a popular cryptocurrency in the future. It emphasizes empowerment, confidence, uniqueness, and beautifying the atmosphere. Join the community and be a part of Kawaii Cat's journey to dominate the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kawaii_logo_f85c1d6845.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

