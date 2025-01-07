module 0xa2c6e0e072c3a805cbe43b12a5d242ae88b3cedea02bfa37a82e768621947109::al {
    struct AL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AL>(arg0, 9, b"AL", b"Snow", b"Sn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f521037-6035-4379-905f-b7ab98ab00b5-IMG_20241006_102532.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AL>>(v1);
    }

    // decompiled from Move bytecode v6
}

