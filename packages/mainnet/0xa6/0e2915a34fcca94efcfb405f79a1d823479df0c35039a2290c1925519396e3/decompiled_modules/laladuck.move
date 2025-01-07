module 0xa60e2915a34fcca94efcfb405f79a1d823479df0c35039a2290c1925519396e3::laladuck {
    struct LALADUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALADUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALADUCK>(arg0, 6, b"LALADUCK", b"LALA DUCK", x"4c414c41204455434b20244c414c414455434b206973207468652063757465737420616e642066756e6e69657374206d656d65636f696e206f6e2074686520535549206e6574776f726b2c206272696e67696e672066756e20616e6420656e7465727461696e6d656e7420746f207468652063727970746f20776f726c642e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ssstwitter_com_1721408116903_7e0d1b2de1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALADUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LALADUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

