module 0xa3c3ad0da368b94a70e53eb9c1f33ba6b6a545090ef599a8e11889109697bc0e::snftz {
    struct SNFTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNFTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNFTZ>(arg0, 6, b"SNFTZ", b"SuiNFTrendz", b"When your JPEGs are worth more than your house ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nft_80dd6dbf12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNFTZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNFTZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

