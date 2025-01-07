module 0x30868b6392788c7ac1ebc8ba4a19986c7efdf74998ec7111781058baa9e2854b::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 6, b"SUIMON", b"Sui Monster", b"suimonster.com . SUIMONSTER NFT's for token holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/555_62133ea400.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

