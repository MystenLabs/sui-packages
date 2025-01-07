module 0x87890fe137e3b1f7fe9cfd3ca191ab429e169e2ec368cec06e3bab479d1100c7::sauce {
    struct SAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAUCE>(arg0, 6, b"Sauce", b"SUI Sauce", x"20537569205361756365202d20546865207370696369657374206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e21200a225375692053617563652077696c6c204275726e205468656d20416c6c22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sauce_49d6c12cdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

