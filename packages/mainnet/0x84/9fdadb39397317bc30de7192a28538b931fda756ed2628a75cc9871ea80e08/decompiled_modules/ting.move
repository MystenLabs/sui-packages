module 0x849fdadb39397317bc30de7192a28538b931fda756ed2628a75cc9871ea80e08::ting {
    struct TING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TING>(arg0, 9, b"TING", b"WAITING", b"MR. BEAB DOLL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d0824ad-6fd7-4ffd-be1e-ad3540c2b336.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TING>>(v1);
    }

    // decompiled from Move bytecode v6
}

