module 0x7dcda28499318dfe47cf7f3856b9288d039601821121e54bcd2d86f3080e38ab::joguman {
    struct JOGUMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOGUMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOGUMAN>(arg0, 6, b"JOGUMAN", b"JOGUMAN SUI", x"7765206172652074696e79206c6974746c652028244a4f47554d414e29206265696e67732e20627574207468617420646f65736e2774206d65616e20776527726520756e696d706f7274616e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qoy_BY_Xvr_400x400_8a6478e777.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOGUMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOGUMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

