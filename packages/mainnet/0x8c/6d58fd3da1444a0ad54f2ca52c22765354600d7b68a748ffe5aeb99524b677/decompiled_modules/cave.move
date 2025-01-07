module 0x8c6d58fd3da1444a0ad54f2ca52c22765354600d7b68a748ffe5aeb99524b677::cave {
    struct CAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAVE>(arg0, 9, b"CAVE", b"Cave", b"meme cave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be2e1bd0-8445-4b69-9a7a-ebd375f92272.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

