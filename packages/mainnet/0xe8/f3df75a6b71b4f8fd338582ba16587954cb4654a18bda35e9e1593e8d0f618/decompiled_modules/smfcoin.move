module 0xe8f3df75a6b71b4f8fd338582ba16587954cb4654a18bda35e9e1593e8d0f618::smfcoin {
    struct SMFCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMFCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMFCOIN>(arg0, 9, b"SMFCOIN", b"SMF", b"SMF COIN IS A COMMUNITY TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fb85f84-b79b-4661-b42b-e08458d0f5bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMFCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMFCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

