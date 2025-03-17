module 0x432457903e5b4a44325402a3d4d4956d1f5c2f03d9a78cc25796e8f5bd5cbe08::pb {
    struct PB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PB>(arg0, 9, b"PB", b"picbox", x"6e68c3a0206e676fe1baa169206769616f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2aa8cd57-774c-4c36-8f4d-66b08eececed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PB>>(v1);
    }

    // decompiled from Move bytecode v6
}

