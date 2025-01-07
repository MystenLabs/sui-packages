module 0x813a3414aa30951e6e246466bc26937d28a8ab426656777731bd64e0132c4329::dora {
    struct DORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DORA>(arg0, 6, b"DORA", b"DORA ON SUI", b"Dora is only ai agent which enhance the experiance of your travel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000147176_754e174089.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DORA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

