module 0x6d957bf02535522332420f2fbf49581fd5695724e10d42c0e3b1898b58d80f2::dft {
    struct DFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFT>(arg0, 9, b"DFT", b"DragonFT", b"Dragon Fight is an exciting fantasy-themed game available for both PC and Telegram Mini App users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9d34bd5-909c-4cd9-97a5-50dfe1f99ec5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

