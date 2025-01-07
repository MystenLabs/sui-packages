module 0x2e2d1aca93b2bf85bc2f2d03a37cdfb97b16e0dd80b0cee63e8d752152419795::ela {
    struct ELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELA>(arg0, 9, b"ELA", b"ELLA", b"ELLA is a cutting-edge token that aims to revolutionize the wellness and healthcare sectors. By leveraging blockchain technology, ELLA provides seamless access to health services.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffca43f4-9e35-4c55-bfa3-5be7b01b0f36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELA>>(v1);
    }

    // decompiled from Move bytecode v6
}

