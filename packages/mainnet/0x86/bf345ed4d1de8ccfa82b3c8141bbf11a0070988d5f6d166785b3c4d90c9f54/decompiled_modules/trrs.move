module 0x86bf345ed4d1de8ccfa82b3c8141bbf11a0070988d5f6d166785b3c4d90c9f54::trrs {
    struct TRRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRRS>(arg0, 6, b"TRRS", b"Trump rally is reading", x"24545252532069732061206e6577206d656d65636f696e2061626f757420746865206c6173746573742072616c6c792074686174207472756d7020646964206974206120676f6f64206f6e6520696620796f75206c6f7665207472756d70206a6f696e20757320746f206d6f6f6e2074686973206d656d650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Pm8_Vg8muc_XN_Lcpg_Sphv_Gd_NC_2_ZW_52_L6b_Y_Za_K_Riyef_Vp2_5fc83f6643.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

