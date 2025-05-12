module 0xab35cb794c70e9dd6ce87dba9cca3c3354ce3b46b94b7437bac703f122168899::asss {
    struct ASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSS>(arg0, 9, b"ASSS", b"AS", b"ASSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/277baffe-8518-4016-9653-4c4a87463bb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

