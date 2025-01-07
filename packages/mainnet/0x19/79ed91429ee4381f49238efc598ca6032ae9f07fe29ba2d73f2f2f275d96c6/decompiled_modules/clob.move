module 0x1979ed91429ee4381f49238efc598ca6032ae9f07fe29ba2d73f2f2f275d96c6::clob {
    struct CLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOB>(arg0, 6, b"CLOB", b"CLOB token", x"5468656d3a20596f756c6c206e6576657220756e6465727374616e6420706172616c6c656c20657865637574696f6e2077656c6c20656e6f75676820746f207573652044656570426f6f6b0a0a646576733a2046756c6c79206f6e636861696e2e204361706974616c20656666696369656e742e204d6f737420706572666f726d616e7420434c4f422e204c6f77206c6174656e637920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3330_9bb6fdebc2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

