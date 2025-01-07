module 0x4542b84ef2bfad16e1b894d8065922ea7bb96590b603bfa6d4ecea403202836::aimw {
    struct AIMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMW>(arg0, 9, b"AIMW", b"AImeow", b"AImeow is a meme coin. That you buy and hold for fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9870b026-30a5-48e1-b135-1dd8478d3bc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

