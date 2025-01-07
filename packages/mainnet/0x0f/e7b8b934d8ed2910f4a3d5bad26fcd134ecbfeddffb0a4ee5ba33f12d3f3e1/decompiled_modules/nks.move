module 0xfe7b8b934d8ed2910f4a3d5bad26fcd134ecbfeddffb0a4ee5ba33f12d3f3e1::nks {
    struct NKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKS>(arg0, 9, b"NKS", b"Nika sui", b"Funy ghj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eeb82d17-d773-4ba0-9222-ba73256a0209.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

