module 0xb3f9c75d636f7a18d58e4af65c205b130af6d27523edb0db6336d2c494cf0444::dmm {
    struct DMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMM>(arg0, 9, b"DMM", b"Djtmeeeeee", b"Ciu toi voiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ccfbc31ff1fec6ba5696c222e8b5a361blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

