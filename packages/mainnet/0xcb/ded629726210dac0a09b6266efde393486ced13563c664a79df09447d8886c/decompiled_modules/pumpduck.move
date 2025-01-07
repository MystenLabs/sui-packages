module 0xcbded629726210dac0a09b6266efde393486ced13563c664a79df09447d8886c::pumpduck {
    struct PUMPDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPDUCK>(arg0, 6, b"PumpDuck", b"Pump Duck", b"Pump Duck the terror comes in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pom_e198f47046.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

