module 0x1eb9ddf3e62bc033320247558bb95c146eeff07eeb3b849dd7bcaba4803fcb10::wgc {
    struct WGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGC>(arg0, 6, b"WGC", b"SUI World Game", b"WGC are a team of serial founders, gamers, and crypto holders who believe in the benefits of gaming as a viable way of anyone to access transferable skills,social connection, and the global,digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738598532425.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

