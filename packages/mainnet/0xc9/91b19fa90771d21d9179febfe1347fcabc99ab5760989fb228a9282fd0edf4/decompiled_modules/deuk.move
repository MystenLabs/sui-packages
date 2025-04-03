module 0xc991b19fa90771d21d9179febfe1347fcabc99ab5760989fb228a9282fd0edf4::deuk {
    struct DEUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEUK>(arg0, 9, b"DEUK", b"fsjyt", b"dtyugk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/100a97c845463ef281d3eeb948d75bb0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEUK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEUK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

