module 0x7b093551f8edad971fb0222a6eb2e564ebdf96f954294d3ee125c0d52b109255::bychill {
    struct BYCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYCHILL>(arg0, 6, b"BYCHILL", b"BABY CHILL", b"Im Baby Chill, been vibin since the day I was born. Im chill now, Ill be chill when I grow up, and Ill be chill when Im all wrinkly too.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241128_060710_505_69ec93a570.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYCHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYCHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

