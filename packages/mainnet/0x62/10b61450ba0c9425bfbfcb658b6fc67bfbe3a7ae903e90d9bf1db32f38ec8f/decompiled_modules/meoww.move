module 0x6210b61450ba0c9425bfbfcb658b6fc67bfbe3a7ae903e90d9bf1db32f38ec8f::meoww {
    struct MEOWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWW>(arg0, 9, b"MEOWW", b"MEWINGGG", b"MEOW IS MY BOSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f971a92-548c-45e3-b70e-3eed7834cbc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

