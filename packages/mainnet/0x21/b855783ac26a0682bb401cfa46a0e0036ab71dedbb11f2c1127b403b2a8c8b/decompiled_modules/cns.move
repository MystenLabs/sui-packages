module 0x21b855783ac26a0682bb401cfa46a0e0036ab71dedbb11f2c1127b403b2a8c8b::cns {
    struct CNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNS>(arg0, 6, b"CNS", b"Crash Nitro On Sui", b"Welcome to the speed addicts club! Be careful of getting infected with the racing virus from Crash!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_08_14_38_30_9c657b2cc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

