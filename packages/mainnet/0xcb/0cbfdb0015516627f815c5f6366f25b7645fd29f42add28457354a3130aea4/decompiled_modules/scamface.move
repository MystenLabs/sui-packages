module 0xcb0cbfdb0015516627f815c5f6366f25b7645fd29f42add28457354a3130aea4::scamface {
    struct SCAMFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMFACE>(arg0, 6, b"SCAMFACE", b"scamface", b"Exhausted. This is picture number 155, which I own in OpenSea. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nft_155_1b0f207b24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMFACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAMFACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

