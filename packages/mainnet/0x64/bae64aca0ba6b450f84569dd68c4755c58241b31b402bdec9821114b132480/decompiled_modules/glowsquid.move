module 0x64bae64aca0ba6b450f84569dd68c4755c58241b31b402bdec9821114b132480::glowsquid {
    struct GLOWSQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOWSQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOWSQUID>(arg0, 6, b"GLOWSQUID", b"Glow Squid", b"A glowing force from the depths of Sui. Mysterious, bright, and ready to light up the Sui Waters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_Pnx_Zw_Il_400x400_2e05e2a3c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOWSQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOWSQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

