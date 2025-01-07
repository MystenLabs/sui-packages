module 0x3960a2b8ae0d188316dcc95bd4864fba7a9355a7de2b767b227bfa3d8a31f289::lontee {
    struct LONTEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONTEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONTEE>(arg0, 9, b"LONTEE", b"SAGIRI", b"Hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8793b835-bb97-433b-8f8a-c9da31a99a30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONTEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONTEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

