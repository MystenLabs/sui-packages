module 0x8f141b9cff04a6caaed36eb87916076bb7cae6dbfd895af1ef10d679fd930f06::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"BOBE ON SUI", b"BOBEEEEEEEEEBOBEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038995_b67051a5d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

