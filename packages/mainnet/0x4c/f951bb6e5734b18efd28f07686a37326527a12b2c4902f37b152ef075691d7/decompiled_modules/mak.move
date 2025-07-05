module 0x4cf951bb6e5734b18efd28f07686a37326527a12b2c4902f37b152ef075691d7::mak {
    struct MAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAK>(arg0, 6, b"MAK", b"$MAK", b"Official MaKDuck finance ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5113_1fdbb595e8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

