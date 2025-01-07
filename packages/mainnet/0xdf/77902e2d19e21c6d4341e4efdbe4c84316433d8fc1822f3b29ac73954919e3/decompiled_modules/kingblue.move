module 0xdf77902e2d19e21c6d4341e4efdbe4c84316433d8fc1822f3b29ac73954919e3::kingblue {
    struct KINGBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGBLUE>(arg0, 6, b"KINGBLUE", b"KING BLUE", b"The king of Sui is $KINGBLUE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3905_8b16a4b4d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

