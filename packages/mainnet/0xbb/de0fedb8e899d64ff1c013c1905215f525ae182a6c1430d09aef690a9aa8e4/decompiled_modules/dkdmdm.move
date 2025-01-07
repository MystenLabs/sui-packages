module 0xbbde0fedb8e899d64ff1c013c1905215f525ae182a6c1430d09aef690a9aa8e4::dkdmdm {
    struct DKDMDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKDMDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKDMDM>(arg0, 9, b"DKDMDM", b"Kshek", b"Fjfjjcjcj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa5cc672-ba61-4ae5-9f8e-3c44e167a318.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKDMDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKDMDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

