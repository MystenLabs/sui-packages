module 0xf7d295731186ba1f62d671bc884571bfc24d22107bcc28087ceeabd00661f75f::flwrz {
    struct FLWRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLWRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLWRZ>(arg0, 6, b"FLWRZ", b"Followerz", b"%100 Community Token,FLWRZ Token is the official token of the Followerz VIP platform, a premier destination for social media marketing (SMM) services. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_removebg_e8c56b1a91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLWRZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLWRZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

