module 0x6adf96cabec917a4eae273c6a7f9e2a94ba376d708dbf995671df93d869ace1f::whsk {
    struct WHSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHSK>(arg0, 9, b"WHSK", b"Whisker Fund", b"Wisker Fund is the place you want to be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1778709032595046400/fJVkw30W.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHSK>(&mut v2, 230000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHSK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

