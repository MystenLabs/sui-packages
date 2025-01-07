module 0x73d5a25f8232bf9584d549ca00abd419af7b554f303dce53a1a0fd81b09a8d35::mesui {
    struct MESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESUI>(arg0, 9, b"MESUI", b"Memesui", b"Token meme sui to bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a5d4fc2-824c-4e9a-8088-6c4f1e448b32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

