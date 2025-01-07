module 0x32facd5c7ea9c147b15c68a07de4f664ad560b8a4bd6e60fd847581a5c181429::wht {
    struct WHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHT>(arg0, 9, b"WHT", b"Wheat", b"it's a long jurney from old times and it need time and effort to become a bread", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/687b5dc3-f5f7-42f5-945e-a22bdc6aebef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

