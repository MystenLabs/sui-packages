module 0x44f2ae6049449901a941f9c478ebc7b8ed349430a3ff04308628521090e07b4d::pain {
    struct PAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAIN>(arg0, 6, b"PAIN", b"Pain", b"NO PAIN NO GAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032629_a10f3930d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

