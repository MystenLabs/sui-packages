module 0xabbfaaf56b6bf7c3908af68d0664cb0c59d13e29f9e3d8ef71a7dc9b1bfc4610::bolt {
    struct BOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLT>(arg0, 6, b"BOLT", b"First Bolt on Sui", b"First Bolt on Sui.Website: https://www.boltonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_5_c25d9512cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

