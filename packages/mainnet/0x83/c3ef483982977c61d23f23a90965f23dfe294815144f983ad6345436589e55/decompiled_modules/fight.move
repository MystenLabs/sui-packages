module 0x83c3ef483982977c61d23f23a90965f23dfe294815144f983ad6345436589e55::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 9, b"FIGHT", b"TrumpCoin", b"TRUMP FOR PRESIDENT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a2719ca-8258-476f-ab5a-f3e39021f5d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

