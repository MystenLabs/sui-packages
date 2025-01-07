module 0x89e6fd8b2587c75f6c7080afcae0f03087341ea86d9d0b0463f7696402ab5275::ela {
    struct ELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELA>(arg0, 9, b"ELA", b"ELLA", b"ELLA is a cutting-edge token that aims to revolutionize the wellness and healthcare sectors. By leveraging blockchain technology, ELLA provides seamless access to health services.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91091ca0-f687-4237-869d-5a04cd94f2cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELA>>(v1);
    }

    // decompiled from Move bytecode v6
}

