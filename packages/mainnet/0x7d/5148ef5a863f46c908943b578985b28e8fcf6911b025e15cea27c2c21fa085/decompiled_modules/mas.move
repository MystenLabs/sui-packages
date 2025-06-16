module 0x7d5148ef5a863f46c908943b578985b28e8fcf6911b025e15cea27c2c21fa085::mas {
    struct MAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAS>(arg0, 6, b"MAS", b"MASS", b"GIVE ME PEACE OF MIND TO ACCEPT WHAT I CAN'T CHANGE, COURAGE TO CHANGE WHAT I CAN, AND WISDOM TO MAKE ME KNOW THE DIFFERENCE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4783_5d21d0a045.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

