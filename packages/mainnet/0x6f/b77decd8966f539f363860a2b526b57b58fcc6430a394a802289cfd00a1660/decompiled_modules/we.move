module 0x6fb77decd8966f539f363860a2b526b57b58fcc6430a394a802289cfd00a1660::we {
    struct WE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE>(arg0, 9, b"WE", b"WWEA", b"a123aa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f148edec-e357-47ab-9344-440baee28470.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE>>(v1);
    }

    // decompiled from Move bytecode v6
}

