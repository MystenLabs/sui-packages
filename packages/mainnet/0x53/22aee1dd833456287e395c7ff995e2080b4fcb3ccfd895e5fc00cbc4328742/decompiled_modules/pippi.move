module 0x5322aee1dd833456287e395c7ff995e2080b4fcb3ccfd895e5fc00cbc4328742::pippi {
    struct PIPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPI>(arg0, 9, b"PIPPI", b"Pippi coin", b"Pippi is funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1a8e919-a6e6-4ea3-ad85-5b048cbd5022.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

