module 0x7f9e06f1ea19203c7ecd2e4dc6385495199bfe4fbf3979def803b058f7726cd1::updog {
    struct UPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPDOG>(arg0, 6, b"UPDOG", b"What's Updog", b"We've found the updog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0081_04025a16fa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

