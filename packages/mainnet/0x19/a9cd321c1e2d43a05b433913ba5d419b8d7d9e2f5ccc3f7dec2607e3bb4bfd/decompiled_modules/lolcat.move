module 0x19a9cd321c1e2d43a05b433913ba5d419b8d7d9e2f5ccc3f7dec2607e3bb4bfd::lolcat {
    struct LOLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLCAT>(arg0, 6, b"LOLCAT", b"suilolcat", b"cat said LOL, send it to millions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048964_77321332d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

