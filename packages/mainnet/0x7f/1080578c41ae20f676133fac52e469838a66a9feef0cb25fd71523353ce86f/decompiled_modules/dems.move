module 0x7f1080578c41ae20f676133fac52e469838a66a9feef0cb25fd71523353ce86f::dems {
    struct DEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMS>(arg0, 9, b"DEMS", b"DeMS-13", b"So we're calling them \"DeMS-13\" now, right?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4148ab7-c28d-4f8b-bb1f-5cbe323d4632.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

