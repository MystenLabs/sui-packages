module 0x816d200183de19ad15d7d3fe9021212eacd87f81bdbbbf33c2ccf017d50e2e9e::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 6, b"Wojak", b"Thug Wojak", b"Wojak is diffrent memecoin on sui network, Wojak bring bullish to the sui communty ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/67c1e5e1fd813f48c38691f5340d04ea_a74ecf443b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

