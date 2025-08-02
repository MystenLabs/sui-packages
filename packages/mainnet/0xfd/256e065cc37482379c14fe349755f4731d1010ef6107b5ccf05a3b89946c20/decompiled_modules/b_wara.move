module 0xfd256e065cc37482379c14fe349755f4731d1010ef6107b5ccf05a3b89946c20::b_wara {
    struct B_WARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WARA>(arg0, 9, b"bWARA", b"bToken WARA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

