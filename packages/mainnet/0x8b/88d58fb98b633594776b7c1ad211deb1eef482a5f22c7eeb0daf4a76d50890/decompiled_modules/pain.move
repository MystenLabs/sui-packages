module 0x8b88d58fb98b633594776b7c1ad211deb1eef482a5f22c7eeb0daf4a76d50890::pain {
    struct PAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAIN>(arg0, 6, b"PAIN", b"Pain", b"NO PAIN NO GAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032629_95799d7462.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

