module 0xd688efaacf194acec307e64eade506b035411fcd86dd1887da103e2ff4358c77::vrai {
    struct VRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VRAI>(arg0, 6, b"VRAI", b"VR Eddie by SuiAI", b"Your VR AI companion for games and virtual experiences.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Vr_Eddie_logo_avatar_v2_3ac203f441.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VRAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

