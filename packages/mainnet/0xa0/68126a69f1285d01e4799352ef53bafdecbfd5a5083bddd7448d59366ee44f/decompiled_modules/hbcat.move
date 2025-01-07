module 0xa068126a69f1285d01e4799352ef53bafdecbfd5a5083bddd7448d59366ee44f::hbcat {
    struct HBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBCAT>(arg0, 6, b"HBcat", b"Hero Baby Cat", b"Hero Baby Cat is more than just a meme coin  its a mission-driven token with the goal of saving the world !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hero_Baby882_300x300_659310369a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

