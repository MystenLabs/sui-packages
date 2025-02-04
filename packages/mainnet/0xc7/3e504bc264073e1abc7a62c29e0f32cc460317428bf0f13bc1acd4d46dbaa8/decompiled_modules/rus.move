module 0xc73e504bc264073e1abc7a62c29e0f32cc460317428bf0f13bc1acd4d46dbaa8::rus {
    struct RUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUS>(arg0, 9, b"Rus", b"Big Rus", b"2 Big Rus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e1ba747b5f96e13ce802f6e1f6482650blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

