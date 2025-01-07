module 0x95a42d0d529b0e23b27f356e89bdcffbabd299c47d99a74c2750cfde3c62a3b1::zombie {
    struct ZOMBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIE>(arg0, 6, b"ZOMBIE", b"Sui Zombie", b"Meet $ZOMBIE. Its the undead invasion on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zombie_2abe2c5416.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOMBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

