module 0x2735deed2e51d348abb053cbc0a69ce90b23c5bb32055d4724bd7b0dbb467ee1::rogbes {
    struct ROGBES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGBES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGBES>(arg0, 9, b"ROGBES", b"Gbes", b"Gbes is a community driven project aimed at revolutionizing the crypto space. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf3b1215-2912-4fb4-8eee-65f5a887f6a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGBES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROGBES>>(v1);
    }

    // decompiled from Move bytecode v6
}

