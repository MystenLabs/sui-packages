module 0x840f7a7e9ffdb9ef981bf18cc57e831d703b17df4d0b8006cd0e3695986d9fe7::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"PENG", b"PENGSUIN", b"The Premier Penguin of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016306_0a161989c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

