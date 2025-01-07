module 0xd0872355c57e87f52c42bf334c9cf488c8a3b24368e800bddc517b388071a20d::suicide_sq {
    struct SUICIDE_SQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE_SQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE_SQ>(arg0, 9, b"SUICIDE_SQ", b"SUIcide SQ", b"Suicide Squad is on the mission to destroy Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5310476c-0f22-4453-b10e-497e9dc12de4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE_SQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICIDE_SQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

