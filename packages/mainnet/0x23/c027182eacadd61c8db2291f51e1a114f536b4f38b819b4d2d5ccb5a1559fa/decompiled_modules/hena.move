module 0x23c027182eacadd61c8db2291f51e1a114f536b4f38b819b4d2d5ccb5a1559fa::hena {
    struct HENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENA>(arg0, 6, b"HENA", b"hena", b"hena on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000121227_15680a0001.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

