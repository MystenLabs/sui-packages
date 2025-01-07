module 0xe99382a9bfa5555a32608532f2163317b47e838fa70a6c541d791b30ca55113b::luyen {
    struct LUYEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUYEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUYEN>(arg0, 9, b"LUYEN", b"L", b"Luyen Ngo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8952cfb7-cc84-403e-81a2-72f6bbc7f4a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUYEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUYEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

