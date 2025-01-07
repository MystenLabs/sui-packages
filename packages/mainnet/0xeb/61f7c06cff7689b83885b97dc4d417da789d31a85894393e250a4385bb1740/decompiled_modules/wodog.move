module 0xeb61f7c06cff7689b83885b97dc4d417da789d31a85894393e250a4385bb1740::wodog {
    struct WODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WODOG>(arg0, 9, b"WODOG", b"Galimeme", b"Ez money for making...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f09d0cc-75d1-4385-b50c-198de91587f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

