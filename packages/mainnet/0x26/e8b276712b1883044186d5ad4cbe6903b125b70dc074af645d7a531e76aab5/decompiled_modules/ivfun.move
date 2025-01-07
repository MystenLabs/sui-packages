module 0x26e8b276712b1883044186d5ad4cbe6903b125b70dc074af645d7a531e76aab5::ivfun {
    struct IVFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVFUN>(arg0, 9, b"IVFUN", b"Invest Zon", b"Just for fun and grab some", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e721c9b6-1427-4a62-99dd-60862458195a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

