module 0x592b9be9c5e9a7346dd03f0f8df81e92b3d76188ce66ad4b92c39ebc074a9b95::sblu {
    struct SBLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLU>(arg0, 6, b"SBLU", b"SuiBlu ", x"466c6f77696e6720496e6e6f766174696f6e206f6e2074686520426c6f636b636861696e2e200a0a537569426c7520282453424c552920726570726573656e7473207468652070657266656374206861726d6f6e79206f66206e617475726520616e6420746563686e6f6c6f67792c20696e737069726564206279207468652063616c6d2079657420706f77657266756c20666c6f77206f662077617465722e204275696c74206f6e207468652053756920626c6f636b636861696e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733065329199.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBLU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

