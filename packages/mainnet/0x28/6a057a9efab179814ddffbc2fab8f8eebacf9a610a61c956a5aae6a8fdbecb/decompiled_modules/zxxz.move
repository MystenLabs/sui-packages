module 0x286a057a9efab179814ddffbc2fab8f8eebacf9a610a61c956a5aae6a8fdbecb::zxxz {
    struct ZXXZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXXZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXXZ>(arg0, 9, b"ZXXZ", b"xzCxz", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXXZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZXXZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

