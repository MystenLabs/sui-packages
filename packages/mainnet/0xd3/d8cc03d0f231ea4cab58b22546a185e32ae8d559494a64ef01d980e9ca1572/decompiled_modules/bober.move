module 0xd3d8cc03d0f231ea4cab58b22546a185e32ae8d559494a64ef01d980e9ca1572::bober {
    struct BOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBER>(arg0, 9, b"BOBER", b"Bober", b"In Bober We Trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ea57e1e-4e37-43ae-8069-6ef25282d34d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

