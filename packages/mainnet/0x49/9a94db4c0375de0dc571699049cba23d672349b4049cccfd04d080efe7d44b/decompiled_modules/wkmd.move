module 0x499a94db4c0375de0dc571699049cba23d672349b4049cccfd04d080efe7d44b::wkmd {
    struct WKMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKMD>(arg0, 9, b"WKMD", b"KMD", b"Komodo dragon is animal from Indonesian", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f11ba193-2f79-44c2-925e-f7a21c441fce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

