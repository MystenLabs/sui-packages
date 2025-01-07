module 0x8ab8ea7f783a6c581d39f7d00504730b8ab6cdc2b55dffdedaf56543d2e65186::cxv {
    struct CXV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXV>(arg0, 9, b"CXV", b"BHF", b"VXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cdfcad1-0a93-49ff-88d3-a63969e458c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CXV>>(v1);
    }

    // decompiled from Move bytecode v6
}

