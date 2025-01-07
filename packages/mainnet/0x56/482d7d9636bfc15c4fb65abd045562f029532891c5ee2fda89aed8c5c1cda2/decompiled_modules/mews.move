module 0x56482d7d9636bfc15c4fb65abd045562f029532891c5ee2fda89aed8c5c1cda2::mews {
    struct MEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWS>(arg0, 9, b"MEWS", b"MewSui", b"orginal mew on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71b916f6-d12f-4972-9f5a-a50b0a3b6c8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

