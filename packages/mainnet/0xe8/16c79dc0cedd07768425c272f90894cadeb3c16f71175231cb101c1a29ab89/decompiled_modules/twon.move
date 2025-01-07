module 0xe816c79dc0cedd07768425c272f90894cadeb3c16f71175231cb101c1a29ab89::twon {
    struct TWON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWON>(arg0, 6, b"Twon", b"Trumpwon", b"Trumpwon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4241_dc6a2cd962.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWON>>(v1);
    }

    // decompiled from Move bytecode v6
}

