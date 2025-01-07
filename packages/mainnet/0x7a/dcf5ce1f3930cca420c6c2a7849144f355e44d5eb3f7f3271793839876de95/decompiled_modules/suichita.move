module 0x7adcf5ce1f3930cca420c6c2a7849144f355e44d5eb3f7f3271793839876de95::suichita {
    struct SUICHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHITA>(arg0, 6, b"SUICHITA", b"SUICHITA - Pochita of Sui", b"https://x.com/Balltzehk/status/1841509279465128426 - sui pochita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_5_d2a8f29b0c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

