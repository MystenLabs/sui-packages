module 0x63c8f8b32ce6b6fb360d676182bda57e7c28755c3f652ec40ef1294ea4001715::trsl {
    struct TRSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRSL>(arg0, 9, b"TRSL", b"Trishul ", x"f09f94b1205472697368756c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e232a811-589d-40b7-8adc-1e82ccbbb85a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

