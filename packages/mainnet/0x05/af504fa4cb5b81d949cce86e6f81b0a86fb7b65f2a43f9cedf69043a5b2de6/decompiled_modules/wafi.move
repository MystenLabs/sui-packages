module 0x5af504fa4cb5b81d949cce86e6f81b0a86fb7b65f2a43f9cedf69043a5b2de6::wafi {
    struct WAFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAFI>(arg0, 9, b"WAFI", b"AlphaFI ", b"AlphaFI (AFI) - The Meme Coin Revolution on Sui Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a723787b-d42d-4336-a4ee-844809f809fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

