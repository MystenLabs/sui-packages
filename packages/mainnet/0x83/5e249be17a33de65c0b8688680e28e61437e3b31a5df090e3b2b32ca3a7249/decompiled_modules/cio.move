module 0x835e249be17a33de65c0b8688680e28e61437e3b31a5df090e3b2b32ca3a7249::cio {
    struct CIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIO>(arg0, 9, b"CIO", b"Memo", b"Tike", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d20c268-bc6d-48e8-9bcf-215a4c7403bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

