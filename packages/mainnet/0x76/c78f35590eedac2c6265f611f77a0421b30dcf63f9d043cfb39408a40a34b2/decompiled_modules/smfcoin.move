module 0x76c78f35590eedac2c6265f611f77a0421b30dcf63f9d043cfb39408a40a34b2::smfcoin {
    struct SMFCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMFCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMFCOIN>(arg0, 9, b"SMFCOIN", b"SMF Token", b"SMF COIN IS A COMMUNITY TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2144910-7bc0-4791-959d-bb6dd4c212c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMFCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMFCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

