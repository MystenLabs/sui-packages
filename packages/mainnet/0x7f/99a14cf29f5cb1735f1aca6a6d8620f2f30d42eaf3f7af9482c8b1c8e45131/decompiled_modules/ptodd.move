module 0x7f99a14cf29f5cb1735f1aca6a6d8620f2f30d42eaf3f7af9482c8b1c8e45131::ptodd {
    struct PTODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTODD>(arg0, 6, b"Ptodd", b"PeterTodd", b"Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Za_Gc_NW_Xw_AA_Qx_K9_62f1264c66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

