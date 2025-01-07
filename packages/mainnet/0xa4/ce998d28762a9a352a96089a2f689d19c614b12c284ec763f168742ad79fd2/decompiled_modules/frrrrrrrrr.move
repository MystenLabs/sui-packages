module 0xa4ce998d28762a9a352a96089a2f689d19c614b12c284ec763f168742ad79fd2::frrrrrrrrr {
    struct FRRRRRRRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRRRRRRRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRRRRRRRRR>(arg0, 9, b"FRRRRRRRRR", b"hhhhhhhhhh", b"FRPVC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fa07c74-b2ed-4a06-8be2-da15f8b2fcbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRRRRRRRRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRRRRRRRRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

