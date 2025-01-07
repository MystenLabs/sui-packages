module 0x59a6d8e49a6b31abeb40c1a2eb78f70190d2132597202fd21c00be5158bd8437::warcoin {
    struct WARCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCOIN>(arg0, 9, b"WARCOIN", b"WAR", b"Coin of the WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a6582fa-76a9-4419-bf54-e4a1df8cf3e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

