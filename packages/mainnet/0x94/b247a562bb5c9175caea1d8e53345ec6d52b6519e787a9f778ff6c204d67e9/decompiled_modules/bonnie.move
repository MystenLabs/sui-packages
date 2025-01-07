module 0x94b247a562bb5c9175caea1d8e53345ec6d52b6519e787a9f778ff6c204d67e9::bonnie {
    struct BONNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONNIE>(arg0, 9, b"BONNIE", b"Bonnie ", b"Adventure token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1174adb-5e4d-4028-bcb0-7eb68d196833.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

