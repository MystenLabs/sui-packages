module 0xcfcc1219af50fb15812811c5febe38e801e2d79fcdc8c74e351c96533d31bf7d::pnuct {
    struct PNUCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUCT>(arg0, 9, b"PNUCT", b"PNUC", b"MEME OF SOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44d90a6c-b7f0-4928-a0e1-a95290a942fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

