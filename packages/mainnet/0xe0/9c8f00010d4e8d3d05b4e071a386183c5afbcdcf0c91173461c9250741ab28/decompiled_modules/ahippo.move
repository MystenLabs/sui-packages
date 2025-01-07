module 0xe09c8f00010d4e8d3d05b4e071a386183c5afbcdcf0c91173461c9250741ab28::ahippo {
    struct AHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHIPPO>(arg0, 6, b"AHIPPO", b"AAAHIPPO", b"Aaahippo beyond the hippo conspiracy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241007_105242_940_9c8659eb12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

