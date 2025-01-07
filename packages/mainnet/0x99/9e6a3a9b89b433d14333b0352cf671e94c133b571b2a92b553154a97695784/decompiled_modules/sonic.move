module 0x999e6a3a9b89b433d14333b0352cf671e94c133b571b2a92b553154a97695784::sonic {
    struct SONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONIC>(arg0, 6, b"SONIC", b"Sonic Snipe Bot", b"The only trading bot you need. sonicsnipebot.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_085902_dec2d59c73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

