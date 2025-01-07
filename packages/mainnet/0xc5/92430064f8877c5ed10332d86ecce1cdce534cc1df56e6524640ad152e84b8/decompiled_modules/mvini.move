module 0xc592430064f8877c5ed10332d86ecce1cdce534cc1df56e6524640ad152e84b8::mvini {
    struct MVINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVINI>(arg0, 9, b"MVINI", b"Vini", b"Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/893147cc-2989-429f-88c8-7e68e0820935.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MVINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

