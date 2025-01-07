module 0x155ae0c545689e8ea6c094189531959be8bc8dd5a7c6d855db630df0f3f80cfd::ucat {
    struct UCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCAT>(arg0, 6, b"UCAT", b"UGLY CAT SUI", b"Ugly Cat is an ugly cat in the cat world, despised by other cats but he doesn't give up, by chance he plays meme coin on sui internet and becomes a billionaire and is respected by everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7822_c4a7cfa599.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

