module 0x81f3a345133c78fa2fb13c0ef1c83005bb52ccfa58f11866f6c6199483ee3961::balto {
    struct BALTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALTO>(arg0, 6, b"BALTO", b"Balto on SUI", b"The legendary dog arrives on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baltopfp_6a2c085685.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

