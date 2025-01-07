module 0x51233ffa8a933970a5ade4dfef34cb8ddcf183306af26d760ba5d9fdd8f2d123::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 6, b"SAVIOR", b"Savior Trump", x"5468657927726520656174696e672074686520646f677321205468657927726520656174696e6720746865206361747321205468652074696d6520666f7220616c6c2074686520706574206d656d65636f696e73206973206f766572212049742069732074696d6520666f722061206e65772056495020746f2074616b652074686520666f726566726f6e74210a44696420796f75206d6973732074686520244d4147412070756d703f20446f6e2774206d6973732074686973206f6e65212046696c6c20796f75722024534156494f522062616773206e6f7721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1727140598642_c27ceffe00202de1040e17a1e5002bb6_aba97f8060.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

