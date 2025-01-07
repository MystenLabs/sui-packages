module 0x194698d584fcc53444e7b76ff3a51477161d65d3e5cd180f81e4706ca5566c29::sduck {
    struct SDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDUCK>(arg0, 6, b"SDUCK", b"SUIDUCK", b"SUIDUCK SUIDUCK! Community meme, for SUI community, not VCs not rugs only community meme who loves Psuiducks. SUIDUCK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953510237.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

