module 0x8c0b2c56e1250c967239749df9272c779bc4fd7b6380f913feafdd87d2b97de0::oysti {
    struct OYSTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYSTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYSTI>(arg0, 6, b"Oysti", b"Oystipearl", b"I am the pearl,,  And the SUI Chain bends to my whims. Only those who understand true value can approach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014009_73a9d0a575.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYSTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OYSTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

