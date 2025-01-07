module 0xca2357064d9d441e6f2c5e03abdab34adff738ec4dc71a49d1ceba9d7b708f38::hey {
    struct HEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEY>(arg0, 9, b"HEY", b"Kfidjdjdkf", b"Udjsjdkfjdjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/200b55ba-9724-4073-821f-c746e2a2fde8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

