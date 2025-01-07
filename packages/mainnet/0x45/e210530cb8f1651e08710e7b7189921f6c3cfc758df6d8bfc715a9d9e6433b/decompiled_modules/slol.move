module 0x45e210530cb8f1651e08710e7b7189921f6c3cfc758df6d8bfc715a9d9e6433b::slol {
    struct SLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOL>(arg0, 9, b"SLOL", b"$SUI-LOL", b"The name \"$SUI-LOL\" is a combination of the Sui blockchain and internet slang \"LOL,\" a widely recognized expression of laughter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7d30d88-7beb-4bb0-a134-b713e8a998f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

