module 0x565d2a37825d1173ba1866072096a06bf0520e4b04bb55dbecf0d549c5034b4c::ptodd {
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

