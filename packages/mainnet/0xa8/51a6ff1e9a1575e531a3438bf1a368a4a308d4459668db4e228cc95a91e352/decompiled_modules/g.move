module 0xa851a6ff1e9a1575e531a3438bf1a368a4a308d4459668db4e228cc95a91e352::g {
    struct G has drop {
        dummy_field: bool,
    }

    fun init(arg0: G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G>(arg0, 9, b"G", b"GG", b"GG token pump now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01a19a70-e845-4c69-bd4e-c416b4d4dbf7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G>>(v1);
    }

    // decompiled from Move bytecode v6
}

