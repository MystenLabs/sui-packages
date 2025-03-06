module 0x13a438176180f6de889e10e29da2b5639eea0f047881a1e494d3417d542787::copy {
    struct COPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPY>(arg0, 6, b"COPY", b"CopyX", b"Just a copy of pump.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/copy_logo_d2d502395b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

