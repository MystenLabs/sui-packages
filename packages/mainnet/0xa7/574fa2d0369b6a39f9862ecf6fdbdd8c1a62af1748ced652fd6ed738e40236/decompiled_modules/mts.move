module 0xa7574fa2d0369b6a39f9862ecf6fdbdd8c1a62af1748ced652fd6ed738e40236::mts {
    struct MTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MTS>(arg0, 6, b"MTS", b"MeatStrong by SuiAI", b"New hero, die for vegans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Designer_2_6ad954459c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MTS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

