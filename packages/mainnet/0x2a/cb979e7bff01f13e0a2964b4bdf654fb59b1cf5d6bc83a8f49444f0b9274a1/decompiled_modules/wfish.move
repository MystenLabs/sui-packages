module 0x2acb979e7bff01f13e0a2964b4bdf654fb59b1cf5d6bc83a8f49444f0b9274a1::wfish {
    struct WFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFISH>(arg0, 6, b"WFISH", b"Wrapped Fish", b"A fish which is wrapped.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Wmhe1_W_400x400_e7db8daed9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

