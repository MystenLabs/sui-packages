module 0x90c824cc731143fdeb1f64ad418e98cdf07c1ebb95852c78fc7ceb2411f98ca2::kongke {
    struct KONGKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONGKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONGKE>(arg0, 6, b"KONGKE", b"KONGKE SUI", x"4b6f6e676b6520746865206f6e6c79206b696e676b6f6e6720796f75206e6565640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_Fl_V8_M_Ux_400x400_f28120fc55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONGKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KONGKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

