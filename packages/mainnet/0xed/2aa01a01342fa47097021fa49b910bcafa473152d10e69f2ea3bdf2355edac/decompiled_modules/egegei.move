module 0xed2aa01a01342fa47097021fa49b910bcafa473152d10e69f2ea3bdf2355edac::egegei {
    struct EGEGEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGEGEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGEGEI>(arg0, 9, b"EGEGEI", b"Eeg", b"To take some airdrop ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54887668-7f57-4935-b6af-8a9e6095b0dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGEGEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGEGEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

