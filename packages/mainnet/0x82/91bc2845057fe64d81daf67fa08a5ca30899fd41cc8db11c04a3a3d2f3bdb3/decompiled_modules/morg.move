module 0x8291bc2845057fe64d81daf67fa08a5ca30899fd41cc8db11c04a3a3d2f3bdb3::morg {
    struct MORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORG>(arg0, 6, b"MORG", b"MORG DOG ON SUI", b"If you Like dog then you fall in love morg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_140607_a849b7c0d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

