module 0xa972682bb065253de9576717a03570fad962de428a1dca7d1187b2c6f5b7f099::eta {
    struct ETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETA>(arg0, 9, b"ETA", b"Jason ETA", b"WHAT'S YOUR ETAA! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d6597f1-b233-4d95-bf89-b4072e729ad0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

