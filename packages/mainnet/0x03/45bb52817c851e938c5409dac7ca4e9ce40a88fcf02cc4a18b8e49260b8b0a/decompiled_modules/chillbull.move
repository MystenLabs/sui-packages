module 0x345bb52817c851e938c5409dac7ca4e9ce40a88fcf02cc4a18b8e49260b8b0a::chillbull {
    struct CHILLBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBULL>(arg0, 6, b"CHILLBULL", b"Chill Bull", b"Look! The Chill Bull on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHILL_BUL_fac724fff2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

