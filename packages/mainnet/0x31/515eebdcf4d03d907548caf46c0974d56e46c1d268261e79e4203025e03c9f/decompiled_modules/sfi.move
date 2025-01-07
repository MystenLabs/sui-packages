module 0x31515eebdcf4d03d907548caf46c0974d56e46c1d268261e79e4203025e03c9f::sfi {
    struct SFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFI>(arg0, 9, b"SFI", b"ScanFi ", b"This token is based on verifying a meme token for long term hodle. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a36ca37-0bce-444e-aa05-eb09a80a6da7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

