module 0xb19b74b89981354e16ecfc5d3624a7dd26973a08d5614aeac634fb704af5bfad::binnickgeg {
    struct BINNICKGEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINNICKGEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINNICKGEG>(arg0, 9, b"BINNICKGEG", b"Kumalala", x"4920646f6ee2809974206861766520737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbaffd73-fd3f-4fad-b3fe-2f394fd1d0d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINNICKGEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BINNICKGEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

