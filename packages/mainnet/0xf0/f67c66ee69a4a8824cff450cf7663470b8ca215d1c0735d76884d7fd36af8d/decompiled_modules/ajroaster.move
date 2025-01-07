module 0xf0f67c66ee69a4a8824cff450cf7663470b8ca215d1c0735d76884d7fd36af8d::ajroaster {
    struct AJROASTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AJROASTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJROASTER>(arg0, 9, b"AJROASTER", b"AJROAST", b"Aj rooster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50cb49a3-a0f8-4481-ab3c-d7293faaf94e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJROASTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJROASTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

