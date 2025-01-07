module 0xde8ff141193320ebae9eb7bbb3287398414e51cb204daa7f917ac99f0681720c::kopi {
    struct KOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOPI>(arg0, 6, b"KOPI", b"Kopi", b"This motherfucker Kopi is faster than light ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_06_10_T183603_078_fe9ed8bdb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

