module 0xa72d7e4c63f862eedf7b01fdfc084342be4a7593e75d070ab3b5463141c4261::bolts {
    struct BOLTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLTS>(arg0, 6, b"BOLTS", b"Bolt Sui", b"https://www.boltonsui.fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1621728904691_pic_c6a89dec9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

