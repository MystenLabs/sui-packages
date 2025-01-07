module 0xfa8bb67b13f02e2e8ec6c4a4f9ce65c3ea7aa1953319a91c2182ae74abcbccda::mooncat {
    struct MOONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONCAT>(arg0, 6, b"MOONCAT", b"Moon Cat on Sui", b"The most degen cat meme coin arrived on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007059_21cc44b13b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

