module 0x396d3837e4697783adc8d810fd565dbc805f6c60397bac434439d55202fea4a9::heehaw {
    struct HEEHAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEEHAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEEHAW>(arg0, 9, b"HEEHAW", b"Horsenshoe", b"Get in and coming through ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7fab7fd-1e43-4b6d-a590-060033db4980.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEEHAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEEHAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

