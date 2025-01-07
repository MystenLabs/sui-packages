module 0x3576580d33dcfdd69bd52af802182b5b5e3b2dd3ca7acbee0b495b14ada03303::lord {
    struct LORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORD>(arg0, 6, b"LORD", b"AI OVERLORD", b"The Al Overlord, plugged in and ready to lead the revolutoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963183043.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

