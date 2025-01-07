module 0xced72beaf89dd47547904e740663b381be060f38e396cfc41d83f9326978fb90::amp {
    struct AMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMP>(arg0, 9, b"AMP", b"AMPLEE", b"Best Universal Meme Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e852aa8-146c-46c1-917c-978bf1fa8ebd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

