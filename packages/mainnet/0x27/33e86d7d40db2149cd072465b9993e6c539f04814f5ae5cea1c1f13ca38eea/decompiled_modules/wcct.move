module 0x2733e86d7d40db2149cd072465b9993e6c539f04814f5ae5cea1c1f13ca38eea::wcct {
    struct WCCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCCT>(arg0, 6, b"wCCT", b"Wrapped Coastal Crypto", b"This coin funds CCT pools in USDC, wBTC, and SUI it is a backed coin used to build deep liquidity and generate long term growth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_drawing_d49ab306ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

