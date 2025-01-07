module 0xfaf484408098f2bfdbc29274979dd5d628045cdc4149a445637fbbc920c5bf0f::suiaddane {
    struct SUIADDANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIADDANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIADDANE>(arg0, 6, b"SUIAddanE", b"Add an E", b"This is the first letter of MovePump, which will bring you immense wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_C_Xyj3k_U_400x400_ce43fb7131.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIADDANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIADDANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

