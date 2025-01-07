module 0xcba6227be566988c93609fab941523459cba8c49660e70e6762f3a8c2a52a7cb::oysti {
    struct OYSTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYSTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYSTI>(arg0, 6, b"OYSTI", b"Oysti Pearl", b"Oysti and his Precious Pearl, the most dazzling gem in all of the SUI Sea! oystipearl.com . ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1g400_S_G_400x400_1f2d4f9c0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYSTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OYSTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

