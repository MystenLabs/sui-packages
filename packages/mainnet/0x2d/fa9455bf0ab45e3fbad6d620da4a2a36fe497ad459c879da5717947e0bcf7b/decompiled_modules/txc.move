module 0x2dfa9455bf0ab45e3fbad6d620da4a2a36fe497ad459c879da5717947e0bcf7b::txc {
    struct TXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TXC>(arg0, 9, b"TXC", b"Taxic", b"A token for big price explosions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83126ab4-b232-4464-9a77-83e002b64e2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

