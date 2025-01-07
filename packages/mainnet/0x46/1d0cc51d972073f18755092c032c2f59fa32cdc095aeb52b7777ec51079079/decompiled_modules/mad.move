module 0x461d0cc51d972073f18755092c032c2f59fa32cdc095aeb52b7777ec51079079::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAD>(arg0, 6, b"Mad", b"Madapes", b"We are unity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1439_1c89178dff.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

