module 0x1e6197b524fb23450047659eb8604bc59990be25255d2ede8d059e240c2260bc::pen {
    struct PEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEN>(arg0, 9, b"PEN", b"Pen", b"Pencil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1f12d26-7164-4edd-8b64-93462059cc28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

