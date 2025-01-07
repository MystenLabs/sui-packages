module 0xa671ae5fa378dcaf211e0cf296aecfbf5f8029c877bc9e742369e746d107bd6d::cio {
    struct CIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIO>(arg0, 9, b"CIO", b"Memo", b"Tike", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a6b34ee-0c61-4322-9901-4de3094f2f07.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

