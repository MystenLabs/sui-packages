module 0x47320a6530a620d64b2b0f71b28e68494ccf88bd502e615da785d6b808200142::onedaybond {
    struct ONEDAYBOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEDAYBOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEDAYBOND>(arg0, 6, b"ONEDAYBOND", b"ONE DAY BOND", b"1 DAY BOND, made to bond in one day. 95% of the supply goes to the community. No rugs. Hold and stake today. We'll do it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia64yzyqqfgegmsn3dgqfdvig6of6ffi2vvgz2pjceccfbaj6q2ci")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEDAYBOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONEDAYBOND>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

