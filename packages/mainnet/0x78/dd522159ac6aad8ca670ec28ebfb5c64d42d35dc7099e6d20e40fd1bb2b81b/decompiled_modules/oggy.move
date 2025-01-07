module 0x78dd522159ac6aad8ca670ec28ebfb5c64d42d35dc7099e6d20e40fd1bb2b81b::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 6, b"OGGY", b"Oggy ON SUI", x"4f4747592048454c4c4f2054484520574f524c440a57656c636f6d6520746f204f676779206120636f6d6d756e6974792064726976656e2070726f6a656374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_12_22_25_1375f12722.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

