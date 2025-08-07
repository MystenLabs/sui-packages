module 0x7633b986963aaefd8e75eec2c590bea6d4d3153ef2805bc6799f4b6934fb8422::stroll {
    struct STROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STROLL>(arg0, 6, b"STROLL", b"Sui Troll", b"a sui troll, someone who annoys others on the internet for their own amusement. The original comic by Ramirez mocked trolls; however, the image is widely used by trolls.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidlzaqoncebt6mywlgyxtdbogprxftcrj5ex7droi73pkdmyiqxla")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STROLL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

