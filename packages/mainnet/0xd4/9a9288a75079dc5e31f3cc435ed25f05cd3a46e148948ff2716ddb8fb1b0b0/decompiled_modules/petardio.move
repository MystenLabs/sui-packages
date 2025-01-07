module 0xd49a9288a75079dc5e31f3cc435ed25f05cd3a46e148948ff2716ddb8fb1b0b0::petardio {
    struct PETARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETARDIO>(arg0, 6, b"PETARDIO", b"PETARDIO SUI", b"PEPE RETARDIO $petardio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3799_9454686f6c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

