module 0xb6c26b8febb0eb8f0e746db124bb67e6688e71e221b7c240a3726be18fb42af3::meerkat {
    struct MEERKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEERKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEERKAT>(arg0, 9, b"MEERKAT", b"meerkat", b"The Meerkat, a small but fearless mongoose, is the ultimate symbol of community, vigilance, and resilience. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db7906f8-1169-477f-8ae6-4764f1305b33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEERKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEERKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

