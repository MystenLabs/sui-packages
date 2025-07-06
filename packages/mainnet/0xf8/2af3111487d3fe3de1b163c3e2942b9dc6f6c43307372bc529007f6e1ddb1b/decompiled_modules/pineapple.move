module 0xf82af3111487d3fe3de1b163c3e2942b9dc6f6c43307372bc529007f6e1ddb1b::pineapple {
    struct PINEAPPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINEAPPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINEAPPLE>(arg0, 6, b"Pineapple", b"Piniapple SUI", b"I would be very happy if you like it, let's join me and create a team to build an ecosystem on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751786374724.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINEAPPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINEAPPLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

