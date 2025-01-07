module 0x1cd088bc49c19ed1bba93a4877809831f8c2b56f48095c2c636b80cccfaaa06a::nik {
    struct NIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIK>(arg0, 9, b"NIK", b"Nikzo", b"An inspired newbea in the crypto space ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7320826e-8707-492c-9e76-20d5f83e455e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

