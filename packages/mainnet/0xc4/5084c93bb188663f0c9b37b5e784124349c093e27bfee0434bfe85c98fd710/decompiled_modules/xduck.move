module 0xc45084c93bb188663f0c9b37b5e784124349c093e27bfee0434bfe85c98fd710::xduck {
    struct XDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDUCK>(arg0, 6, b"XDUCK", b"XDUCK SUI", b"XDUCK SUI The most memeable memecoin in existence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_23_38_26_351dad3752.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

