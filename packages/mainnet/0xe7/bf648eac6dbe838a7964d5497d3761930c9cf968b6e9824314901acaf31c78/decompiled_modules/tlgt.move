module 0xe7bf648eac6dbe838a7964d5497d3761930c9cf968b6e9824314901acaf31c78::tlgt {
    struct TLGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLGT>(arg0, 9, b"TLGT", b"TallGOAT", b"Tallgoat meme is a slender, species with long legs that taper to pointed hooves, and horns that curl tightly backward, a memecoin representing the Greatest Of All Time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dba0f43b-46a5-4c5e-9a95-a6ca54c6b52a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

