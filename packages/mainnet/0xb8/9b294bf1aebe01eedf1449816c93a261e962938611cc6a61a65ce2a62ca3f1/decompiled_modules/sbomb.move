module 0xb89b294bf1aebe01eedf1449816c93a261e962938611cc6a61a65ce2a62ca3f1::sbomb {
    struct SBOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOMB>(arg0, 6, b"SBomb", b"Sui Bomb", x"53756920426f6d622069732061204d656d6520546f6b656e20696e207468652053756920426c6f636b636861696e2e0a0a4c657427732053756920426f6d62206578706c6f64652021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054110_3dd2dd2c9b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

