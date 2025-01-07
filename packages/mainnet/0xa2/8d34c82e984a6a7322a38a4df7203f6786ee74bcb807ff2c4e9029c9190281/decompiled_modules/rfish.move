module 0xa28d34c82e984a6a7322a38a4df7203f6786ee74bcb807ff2c4e9029c9190281::rfish {
    struct RFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFISH>(arg0, 6, b"Rfish", b"RUGFISH ( SCAMMER HOPFISH )", b"Scammer Hopfish! fuck of!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsfsdfsd_71a20e94a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

