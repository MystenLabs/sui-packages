module 0x226b6c850bc4a0e88b7093156074b1c3f50770146d3d2935604fed8d20fcabe::wowcat {
    struct WOWCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWCAT>(arg0, 6, b"WOWCAT", b"Mr.wowcat", b" Say hello to Mr.Wow $WOWCAT, who started trending on TikTok, Instagram, and YouTube, now he's gonna make some \"WOW\" on SUI #WOWCat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036379_240114441a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOWCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

