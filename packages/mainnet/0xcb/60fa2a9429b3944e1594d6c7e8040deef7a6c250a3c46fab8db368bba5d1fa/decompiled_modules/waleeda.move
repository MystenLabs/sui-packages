module 0xcb60fa2a9429b3944e1594d6c7e8040deef7a6c250a3c46fab8db368bba5d1fa::waleeda {
    struct WALEEDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALEEDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALEEDA>(arg0, 9, b"WALEEDA", b"Fatima", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5b97f3c-f9c7-48ff-88fb-f02384966b3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALEEDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALEEDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

