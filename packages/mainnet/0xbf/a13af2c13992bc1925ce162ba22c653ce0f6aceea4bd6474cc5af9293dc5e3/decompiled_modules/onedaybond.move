module 0xbfa13af2c13992bc1925ce162ba22c653ce0f6aceea4bd6474cc5af9293dc5e3::onedaybond {
    struct ONEDAYBOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEDAYBOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEDAYBOND>(arg0, 6, b"ONEDAYBOND", b"ONE DAY BOND", b"1 DAY BOND, made to bond in one day. 97% of the supply goes to the community. Hold and stake today. We'll do it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia64yzyqqfgegmsn3dgqfdvig6of6ffi2vvgz2pjceccfbaj6q2ci")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEDAYBOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONEDAYBOND>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

