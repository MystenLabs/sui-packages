module 0xcd91b3bf58e25e87babe5f8bba354244c4577fe93316b12db6ca989092d9aceb::h12 {
    struct H12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: H12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H12>(arg0, 9, b"H12", b"HOSE", b"moten", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5950ca08-4af5-46e6-a647-c4675b0e3fc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H12>>(v1);
    }

    // decompiled from Move bytecode v6
}

