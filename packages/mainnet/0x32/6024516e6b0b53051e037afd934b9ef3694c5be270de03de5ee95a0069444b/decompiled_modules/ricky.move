module 0x326024516e6b0b53051e037afd934b9ef3694c5be270de03de5ee95a0069444b::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKY>(arg0, 6, b"RICKY", b"Ricky the penguin", b"Hey, it's Ricky!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734473821180.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

