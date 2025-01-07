module 0x2dbd7757c424ba89486e70d2c404dd6c168c6fae18a5033d22329539fff52740::winy {
    struct WINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINY>(arg0, 9, b"WINY", b"Winifred", b"Personal name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95684a87-f006-4891-843c-de74dbdd36fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

