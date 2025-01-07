module 0xbb3c723bbc0a5f7f00b15c02294aa4dd0dcd67950d2dfc890d57025a91c9caf7::wifapple {
    struct WIFAPPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFAPPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFAPPLE>(arg0, 6, b"WIFAPPLE", b"Dog Wif Apple", b"DOG WIF APPLE ON SUI, THE ALPHA APPLE DOG IS HERE FELLAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogwifapple_a902132fcb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFAPPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFAPPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

