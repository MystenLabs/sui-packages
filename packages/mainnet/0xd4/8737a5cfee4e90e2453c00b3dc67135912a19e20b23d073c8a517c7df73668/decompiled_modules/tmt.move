module 0xd48737a5cfee4e90e2453c00b3dc67135912a19e20b23d073c8a517c7df73668::tmt {
    struct TMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMT>(arg0, 9, b"TMT", b"Tomato", x"43c3a0206368756120c491e1bb8f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3bb5f47-1382-492d-be99-5cdfd6aa5b54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

