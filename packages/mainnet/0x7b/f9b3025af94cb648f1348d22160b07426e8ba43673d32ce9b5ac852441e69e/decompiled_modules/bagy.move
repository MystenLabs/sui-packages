module 0x7bf9b3025af94cb648f1348d22160b07426e8ba43673d32ce9b5ac852441e69e::bagy {
    struct BAGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGY>(arg0, 6, b"BAGY", b"Bagy Sui", b"Meet Bagy, the small frog with a big dream and a bag full of potential", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ban_bb2b33f129.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

