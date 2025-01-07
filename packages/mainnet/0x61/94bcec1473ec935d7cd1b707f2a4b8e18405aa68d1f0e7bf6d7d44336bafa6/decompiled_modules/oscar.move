module 0x6194bcec1473ec935d7cd1b707f2a4b8e18405aa68d1f0e7bf6d7d44336bafa6::oscar {
    struct OSCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR>(arg0, 6, b"OSCAR", b"Oscar The Otter", x"57656c636f6d65206672656e7321200a4927616d204f7363617220746865204f74746572206920616d20747279696e6720746f206275696c64207468652062696767657374206e65737420706f7373696272752c206f6e2074686520737569206e6574776f726b20746f2073686f77206f6666206d79206275696c64696e6720736b696c6c7320746f206d79206f74746572206672656e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Log_A_1_a177b1d3b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

