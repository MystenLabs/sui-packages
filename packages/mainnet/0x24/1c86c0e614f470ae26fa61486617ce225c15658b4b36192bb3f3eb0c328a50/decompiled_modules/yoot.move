module 0x241c86c0e614f470ae26fa61486617ce225c15658b4b36192bb3f3eb0c328a50::yoot {
    struct YOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOOT>(arg0, 6, b"YOOT", b"SUIYOOTS", b"Reply Guys On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/02_C92_A74_46_DC_4711_8202_78_A14_C54_DC_15_abea0d1fcf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

