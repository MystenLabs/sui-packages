module 0xdb73becf4deca9905751a880f9f884334f2a093343eb117f86931407fba487da::sms {
    struct SMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMS>(arg0, 6, b"SMS", b"Sui Monkey Space", b"Monkeys for Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1130_b30fbd8ac5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

