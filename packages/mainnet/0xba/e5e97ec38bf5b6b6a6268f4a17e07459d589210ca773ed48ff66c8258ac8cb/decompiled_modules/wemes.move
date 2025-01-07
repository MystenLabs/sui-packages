module 0xbae5e97ec38bf5b6b6a6268f4a17e07459d589210ca773ed48ff66c8258ac8cb::wemes {
    struct WEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEMES>(arg0, 9, b"WEMES", b"Weme", b"The that what why time over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53c237df-f7b0-4920-895d-2c78d18d5afe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

