module 0xbd2b53aa15fa36723176aceba69e29dc2a95958a6731ed41ec194403ddaded29::racoinsui {
    struct RACOINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACOINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACOINSUI>(arg0, 6, b"Racoinsui", b"Racoin", b"Fon Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001120_b3bae16735.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACOINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACOINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

