module 0xdcdbcd1af81d4629f47bb51cc38ec6892cf457888305e2c275f70d7b17f157cf::duks {
    struct DUKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKS>(arg0, 6, b"DUKS", b"Duks", b"Hi, Im an athletic and funny cock, what else do you want from me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_26_T175219_111_39c3e8e1c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

