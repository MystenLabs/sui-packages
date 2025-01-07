module 0x9e6e4208e66c667b81fa19da49961015bc7a257a7551d8e6dbc9305dcc9a2315::meomeo {
    struct MEOMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOMEO>(arg0, 9, b"MEOMEO", b"meomeo", b"meomeopump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0be9215-c759-4af7-b341-41e711dc3177.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

