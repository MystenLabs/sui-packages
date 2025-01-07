module 0x9b3954458c1a20e39b3c699d5de3eb2670ee0432ffb440d263cceda8001bbbed::gachi {
    struct GACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GACHI>(arg0, 9, b"GACHI", b"Billy TON", b"Billy HerringTON - The first meme token Gachi Muchi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b24c351f-5b0d-4643-84d1-acdc9a2bde80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

