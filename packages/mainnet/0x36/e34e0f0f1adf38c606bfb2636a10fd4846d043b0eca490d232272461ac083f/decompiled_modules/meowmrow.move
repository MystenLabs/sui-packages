module 0x36e34e0f0f1adf38c606bfb2636a10fd4846d043b0eca490d232272461ac083f::meowmrow {
    struct MEOWMROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWMROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWMROW>(arg0, 6, b"MEOWMROW", b"MEOWMROW on SUI", x"546869732063617420646f65736e2774206d656f772c206974206d726f7773206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b291b05c_9fd0_4de9_9147_87c2ce3c6c21_98af1aa17a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWMROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWMROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

