module 0x45abe0fdf04642188c7b470015f1f3954998bab56fa92e2ffa39a6efe5de667::aloo {
    struct ALOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALOO>(arg0, 6, b"ALOO", b"XLOL", b"XXX token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd3mro_Fd_Ax_Pcq_Wp7_Dcmvtf3kv_ARH_8g_H_Jy_Hrx94k6tc416_a2d1fc335a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

