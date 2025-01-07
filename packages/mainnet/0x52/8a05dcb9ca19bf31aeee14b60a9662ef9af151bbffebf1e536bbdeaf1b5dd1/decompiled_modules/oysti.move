module 0x528a05dcb9ca19bf31aeee14b60a9662ef9af151bbffebf1e536bbdeaf1b5dd1::oysti {
    struct OYSTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYSTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYSTI>(arg0, 6, b"Oysti", b"Oystipearl", b"I am the pearl,,  And the SUI Chain bends to my whims. Only those who understand true value can approach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014009_c0a8b907f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYSTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OYSTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

