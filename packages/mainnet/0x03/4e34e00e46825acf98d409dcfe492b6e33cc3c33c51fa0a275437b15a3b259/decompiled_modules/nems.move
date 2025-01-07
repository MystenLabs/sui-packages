module 0x34e34e00e46825acf98d409dcfe492b6e33cc3c33c51fa0a275437b15a3b259::nems {
    struct NEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMS>(arg0, 9, b"NEMS", b"Nem", b"Games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7f1af57-d441-4406-8c9c-8bf4319b6a74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

