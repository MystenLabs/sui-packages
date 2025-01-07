module 0xd2f6637a89b33b480859c241c8d94111eb4e74236fd096d045aa9c87b1158621::dump {
    struct DUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMP>(arg0, 6, b"DUMP", b"DUMP SUI", b"DUMMP PUMMY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/24046a36_a0ba_468b_b427_b913c2a11197_a4079dfd57.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

