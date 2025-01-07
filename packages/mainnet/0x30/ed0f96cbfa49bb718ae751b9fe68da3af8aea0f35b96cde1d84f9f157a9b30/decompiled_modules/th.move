module 0x30ed0f96cbfa49bb718ae751b9fe68da3af8aea0f35b96cde1d84f9f157a9b30::th {
    struct TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TH>(arg0, 9, b"TH", b"TembHok", b"kurator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1b63835-62a8-48b1-86bc-f57eb99b08ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

