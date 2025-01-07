module 0x5c164c9f1b52661ff796a3077721dda4d09e3c41b3b9507cd0949ff6f19327a4::mdung {
    struct MDUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDUNG>(arg0, 9, b"MDUNG", b"MEENDUNG", b"Brother to hippo baby!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e08e1f55-96b6-40b3-be07-19849f7a5341.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

