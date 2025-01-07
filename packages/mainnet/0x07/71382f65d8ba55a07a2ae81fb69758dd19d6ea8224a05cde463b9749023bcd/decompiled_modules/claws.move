module 0x771382f65d8ba55a07a2ae81fb69758dd19d6ea8224a05cde463b9749023bcd::claws {
    struct CLAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWS>(arg0, 6, b"Claws", b"Claws The Crab", b"Come on don't be shellfish. Hodl strong and join the crabs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Claws_2a5657c997.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

