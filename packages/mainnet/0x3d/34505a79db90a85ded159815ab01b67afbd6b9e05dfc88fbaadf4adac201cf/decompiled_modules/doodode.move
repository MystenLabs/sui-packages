module 0x3d34505a79db90a85ded159815ab01b67afbd6b9e05dfc88fbaadf4adac201cf::doodode {
    struct DOODODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODODE>(arg0, 9, b"DOODODE", b"DOOD", b"My WEWE 1M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1e9302d-bc22-444a-966f-b05b3eb41d16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOODODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

