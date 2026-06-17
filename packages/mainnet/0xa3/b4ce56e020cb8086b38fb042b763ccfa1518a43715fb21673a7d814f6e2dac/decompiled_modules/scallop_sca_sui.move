module 0xa3b4ce56e020cb8086b38fb042b763ccfa1518a43715fb21673a7d814f6e2dac::scallop_sca_sui {
    struct SCALLOP_SCA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SCA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SCA_SUI>(arg0, 9, b"sScaSui", b"sScaSui", b"Scallop interest-bearing token for scaSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://63e7tik3kmvyvfwbttb4fj3n5mmau5lc3wmwhv25skd2wpisl6ia.arweave.net/9sn5oVtTK4qWwZzDwqdt6xgKdWLdmWPXXZKHqz0SX5A")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SCA_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SCA_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

