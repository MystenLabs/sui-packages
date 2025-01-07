module 0x823a8871ec93ecfbafae832ebd593adda6538547c7c36ffcbf3bc5d4b521a2c1::sminem {
    struct SMINEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMINEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMINEM>(arg0, 6, b"SMINEM", b"MOVE SMINEM", b"Eminem on SUI ($SMINEM)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3833_2a0e4a4243.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMINEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMINEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

