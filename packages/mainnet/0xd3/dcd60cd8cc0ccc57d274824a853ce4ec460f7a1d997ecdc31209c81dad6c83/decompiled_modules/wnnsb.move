module 0xd3dcd60cd8cc0ccc57d274824a853ce4ec460f7a1d997ecdc31209c81dad6c83::wnnsb {
    struct WNNSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNNSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNNSB>(arg0, 9, b"WNNSB", b"jeken", b"hejsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05c8225b-8ba8-44df-ad24-ff56a5c47441.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNNSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNNSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

