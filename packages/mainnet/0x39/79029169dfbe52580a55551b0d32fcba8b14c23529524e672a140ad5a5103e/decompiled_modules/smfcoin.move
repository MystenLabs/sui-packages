module 0x3979029169dfbe52580a55551b0d32fcba8b14c23529524e672a140ad5a5103e::smfcoin {
    struct SMFCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMFCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMFCOIN>(arg0, 9, b"SMFCOIN", b"SMF", b"SMF COIN IS A COMMUNITY TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5969140-e23b-4658-8bec-4909d1fa503e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMFCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMFCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

