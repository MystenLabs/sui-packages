module 0xf2329c38e507960ae5072b2c7b18691517568d9f14b20a393607e59027ff2c8b::suiapt {
    struct SUIAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPT>(arg0, 9, b"SUIAPT", b"Sui vs Aptos", b"SUIAPT IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn-icons-png.flaticon.com/512/890/890026.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIAPT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

