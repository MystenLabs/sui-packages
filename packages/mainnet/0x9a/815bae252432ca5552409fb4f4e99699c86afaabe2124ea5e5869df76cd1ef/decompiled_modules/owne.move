module 0x9a815bae252432ca5552409fb4f4e99699c86afaabe2124ea5e5869df76cd1ef::owne {
    struct OWNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWNE>(arg0, 9, b"OWNE", b"hdjd", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/720b76f0-45b7-464c-9445-4991b1240395.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

