module 0xe4ee3ca785661567d055c69f6caa7e8d64fa5b7b1455ebe18473d8d6689dab5a::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 9, b"ANON", b"Anon sui", b"Anon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e24e9075-a07f-448f-b176-70887acd47cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANON>>(v1);
    }

    // decompiled from Move bytecode v6
}

