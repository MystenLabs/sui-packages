module 0x1fb5e7c92edfe87533b9dbc3b7c71c30ef6469bd9f2c79c210661c87327e375a::wwee {
    struct WWEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWEE>(arg0, 9, b"WWEE", b"Wewa", b"Dont but", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/809983cd-31c1-4a9e-8deb-ca6013a85ef8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

