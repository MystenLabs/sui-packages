module 0x404d06a20557b91992fc5f76b96c248e7cc07e947316845864be3596c8cc543c::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"Neiro on Sui", b"The First Neiro on Sui Ecosystem, just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955191642.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

