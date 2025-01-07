module 0x5f54f94a471d4065b9b61179177a15c44651b733f7c09b43cde3be1ed62cf2c0::wap {
    struct WAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAP>(arg0, 6, b"WAP", b"Wet Ass pussy", b"Cardi b new cat surfaced onchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1938_b0c29c0c4b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

