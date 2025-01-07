module 0x58d20a642a9928fe649d5dd2076f5a85df249fa329c3ce4817680101cbaa4f37::wave3 {
    struct WAVE3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE3>(arg0, 9, b"WAVE3", b"Meme wave", b"wave3 is born from the SUI ecosystem and is developed based on a strong community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d13bbf6-8bf6-4d1c-9282-ff1634b7c7df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE3>>(v1);
    }

    // decompiled from Move bytecode v6
}

