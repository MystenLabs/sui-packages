module 0xc8ce667311d327db9333d16b6f3159bb15d2ec15bb13cb1aa31ebbaa3df9073c::a333 {
    struct A333 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A333, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A333>(arg0, 6, b"A333", b"333 AI", b"XXXX 3333", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/934accd2c616b0692dce92faaa84fe8a_56176d4740.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A333>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A333>>(v1);
    }

    // decompiled from Move bytecode v6
}

