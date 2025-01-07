module 0xb7f775189b88c2d675cb73c10b420be78408e968412271e913039781807ce986::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLY>(arg0, 9, b"WALLY", b"PnutBro", b"Peanuts Brother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d890b909-1ab8-4a6c-b16e-507e3e0c060e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

