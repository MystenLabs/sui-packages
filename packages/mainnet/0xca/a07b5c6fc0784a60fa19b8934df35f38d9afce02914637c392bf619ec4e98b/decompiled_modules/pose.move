module 0xcaa07b5c6fc0784a60fa19b8934df35f38d9afce02914637c392bf619ec4e98b::pose {
    struct POSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POSE>(arg0, 6, b"POSE", b"Posuidon by SuiAI", b"https://x.com/posuidon_io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/d_Yh4_K_Qc_E_400x400_ed77b0f184.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POSE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

