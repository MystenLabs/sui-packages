module 0x7624844115c44876182546d8df472dccf1b713495fd78c335e4ccd64110d0b25::yuni {
    struct YUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUNI>(arg0, 9, b"YUNI", b"ILy yuni ", b"The first my love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6dd34944-7676-4fa6-8eea-8f10cf801331.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

