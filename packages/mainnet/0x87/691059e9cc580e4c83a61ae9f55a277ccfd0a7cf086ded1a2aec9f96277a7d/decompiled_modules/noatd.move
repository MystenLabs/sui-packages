module 0x87691059e9cc580e4c83a61ae9f55a277ccfd0a7cf086ded1a2aec9f96277a7d::noatd {
    struct NOATD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOATD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOATD>(arg0, 6, b"NOATD", b"NoahTheDog", b"NoahTheDog is the most beautiful dog meme that has been created so far on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5791731861167394124_y_2fd35a0f51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOATD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOATD>>(v1);
    }

    // decompiled from Move bytecode v6
}

