module 0xa89730a9fd252662e58476705e3c58f75b5b5b4623bf35729b3f466088e28796::cio {
    struct CIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIO>(arg0, 9, b"CIO", b"Memo", b"Tike", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb141e2c-eeb9-4513-95b0-e1655a49fcea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

