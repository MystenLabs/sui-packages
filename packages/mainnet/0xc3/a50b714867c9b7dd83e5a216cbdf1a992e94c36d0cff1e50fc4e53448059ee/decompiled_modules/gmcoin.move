module 0xc3a50b714867c9b7dd83e5a216cbdf1a992e94c36d0cff1e50fc4e53448059ee::gmcoin {
    struct GMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMCOIN>(arg0, 9, b"GMCOIN", b"GMC", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5d6bb6b-7491-467f-8703-5d7019bdc145.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

