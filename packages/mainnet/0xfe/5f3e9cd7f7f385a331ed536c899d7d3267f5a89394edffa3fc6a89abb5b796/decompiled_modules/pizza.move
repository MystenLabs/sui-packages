module 0xfe5f3e9cd7f7f385a331ed536c899d7d3267f5a89394edffa3fc6a89abb5b796::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", b"Pizza Party", x"2450495a5a4120506172747920697320612066756e20616e642064656c6963696f757320746f6b656e2074686174206272696e6773206a6f790a746f206576657279207061727469636970616e7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gap_Dk5i_Wc_AE_1zc_6bc67f22ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

