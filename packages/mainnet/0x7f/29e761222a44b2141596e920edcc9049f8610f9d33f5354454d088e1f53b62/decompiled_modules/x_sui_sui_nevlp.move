module 0x7f29e761222a44b2141596e920edcc9049f8610f9d33f5354454d088e1f53b62::x_sui_sui_nevlp {
    struct X_SUI_SUI_NEVLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: X_SUI_SUI_NEVLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X_SUI_SUI_NEVLP>(arg0, 9, b"nevLP-x_sui-sui", b"nevLP-x_sui-sui", b"nevLP-x_sui-sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/vaultMmtXsuiSui.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X_SUI_SUI_NEVLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X_SUI_SUI_NEVLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

