module 0xe617d5a437d275dd23e9bcf2b0af2d7781ccdea8ee9303525575c10bd3c582b2::saidog {
    struct SAIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIDOG>(arg0, 6, b"SAIDOG", b"SAIYAN DOG", b"When your token goes beyond its limits... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f6aa153d7b695bcd96554e82cf741b7f_b5b161180e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

