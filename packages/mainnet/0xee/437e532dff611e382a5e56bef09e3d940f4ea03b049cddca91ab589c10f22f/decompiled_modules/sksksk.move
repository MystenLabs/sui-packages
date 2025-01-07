module 0xee437e532dff611e382a5e56bef09e3d940f4ea03b049cddca91ab589c10f22f::sksksk {
    struct SKSKSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKSKSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKSKSK>(arg0, 9, b"SKSKSK", b"Gahann", b"Sjsndnnm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92fcd012-7826-449e-b265-c614992572ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKSKSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKSKSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

