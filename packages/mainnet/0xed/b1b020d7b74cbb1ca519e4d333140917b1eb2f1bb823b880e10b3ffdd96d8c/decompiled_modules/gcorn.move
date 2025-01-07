module 0xedb1b020d7b74cbb1ca519e4d333140917b1eb2f1bb823b880e10b3ffdd96d8c::gcorn {
    struct GCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCORN>(arg0, 6, b"GCORN", b"GOLDACORN", x"50756d70203120746f6b656e2069747320656173790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GCORN_TC_1v_PH_4_XG_Mcko_DN_Zp_D_84888c2513.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

