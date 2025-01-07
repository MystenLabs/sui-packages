module 0x5725b9c59be79e758ed6b759da715935ca56ddb83c93675df446223366a497b3::mfi {
    struct MFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFI>(arg0, 9, b"MFI", b"MEMEFI", b"MEMEFI is a good token.  You can invest in it if you want.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a383a00-8111-4ab4-b612-349fac34bbbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

