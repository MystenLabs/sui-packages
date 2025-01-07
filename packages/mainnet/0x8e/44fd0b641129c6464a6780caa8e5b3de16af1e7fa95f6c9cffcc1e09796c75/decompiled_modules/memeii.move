module 0x8e44fd0b641129c6464a6780caa8e5b3de16af1e7fa95f6c9cffcc1e09796c75::memeii {
    struct MEMEII has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEII>(arg0, 9, b"MEMEII", b"Memeis", b"THAT GO THEN THIS WHAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a8cb5ac-ea37-4868-9691-2e68cc3e958c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEII>>(v1);
    }

    // decompiled from Move bytecode v6
}

