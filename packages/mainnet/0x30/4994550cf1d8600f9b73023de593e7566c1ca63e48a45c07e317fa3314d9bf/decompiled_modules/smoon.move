module 0x304994550cf1d8600f9b73023de593e7566c1ca63e48a45c07e317fa3314d9bf::smoon {
    struct SMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON>(arg0, 9, b"SMOON", b"SuiMoon", b"SuiMoon (SMOON) is the ultimate meme coin riding the waves of the Sui Network. Fueled by community hype and a mission to reach the moon, SuiMoon is here to take your crypto journey to stellar heights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ba98ca5-8ac8-4bfc-86e2-11974155c05e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

