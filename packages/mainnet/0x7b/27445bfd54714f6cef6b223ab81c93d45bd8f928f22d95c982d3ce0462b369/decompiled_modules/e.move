module 0x7b27445bfd54714f6cef6b223ab81c93d45bd8f928f22d95c982d3ce0462b369::e {
    struct E has drop {
        dummy_field: bool,
    }

    fun init(arg0: E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E>(arg0, 6, b"E", b"EXP", b"This token levels up based on your investment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20241210_170533572_221223c1bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<E>>(v1);
    }

    // decompiled from Move bytecode v6
}

