module 0x69130ea2b8d8ff7c2d43b3659c9e4b1f80d031e5fb95aa8aaa41f9bc6f1b1900::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"Scat", b"Sui Hero Baby Cat", b"ui Hero Baby Cat is more than just a meme coin  its a mission-driven token with the goal of saving the world !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hero_Baby882_1024x1024_4fd9a06d68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

