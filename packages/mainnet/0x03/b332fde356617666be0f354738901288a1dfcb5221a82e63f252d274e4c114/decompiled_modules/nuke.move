module 0x3b332fde356617666be0f354738901288a1dfcb5221a82e63f252d274e4c114::nuke {
    struct NUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUKE>(arg0, 9, b"NUKE", b"NUKETOKEN", b"End of Times", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b43f56a-ee1f-411f-b5a9-06ab052dcb81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

