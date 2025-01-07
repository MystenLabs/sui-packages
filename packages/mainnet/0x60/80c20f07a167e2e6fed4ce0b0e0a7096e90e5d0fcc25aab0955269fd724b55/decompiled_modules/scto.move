module 0x6080c20f07a167e2e6fed4ce0b0e0a7096e90e5d0fcc25aab0955269fd724b55::scto {
    struct SCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCTO>(arg0, 6, b"SCTO", b"SuiCTO", b"Ctoing sui, no dev , no team , 100% CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9778cf761c8d4fb5975aeb33706c0721_edf8fad00d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

