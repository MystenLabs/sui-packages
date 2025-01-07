module 0xc10453026107bcc90fa0b3a78b0b5b55fd3dee78ec2744e045b687f261a21c38::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNY>(arg0, 6, b"Horny", b"Still Horny", b"Still Horny Degen?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1595_9fb38d4af3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

