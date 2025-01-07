module 0x906bac68eda3fe9d7ee609e3ebd6c943e33e85e6302fb6677358ac8fbffff44d::xcroc {
    struct XCROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCROC>(arg0, 6, b"Xcroc", b" Xcroc Green Legend", x"5863726f6320e280932054686520477265656e204c6567656e6420f09f908a207c205371756172652063726f632c20666f726576657220677265656e2e204f6e6c79206f6e6520646972656374696f6e20e28093205550212057687920736574746c6520666f7220616e7920636f6c6f722062757420677265656e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731811709325.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCROC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCROC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

