module 0x1a5b0b582b92c725b312d84e4370412632ec96651c8759cdcceb7e9ae369ec4f::mooncat {
    struct MOONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONCAT>(arg0, 6, b"MOONCAT", b"Moon Cat", b"Let the cat moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uw_B_Ra_ZG_7_400x400_e749cb08a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

