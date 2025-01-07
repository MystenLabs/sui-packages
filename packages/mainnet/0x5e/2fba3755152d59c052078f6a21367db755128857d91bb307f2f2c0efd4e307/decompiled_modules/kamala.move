module 0x5e2fba3755152d59c052078f6a21367db755128857d91bb307f2f2c0efd4e307::kamala {
    struct KAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALA>(arg0, 9, b"KAMALA", b"KamalaUSA", b"POTUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e46dbfef-bff4-4e30-8fde-ffa9aea9f180.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

