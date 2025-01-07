module 0xb237e0280e2d526471ebe1f357eb2141bd8907c6c6733af0962c98b179de8b78::wfcat {
    struct WFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFCAT>(arg0, 6, b"WfCat", b"WifCat", b"WifCatWifCatWifCatWifCatWifCatWifCatWifCat  token launched", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_29_at_17_04_17_244da2df42.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

