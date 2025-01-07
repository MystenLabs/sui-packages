module 0x7eaac77c0b7a4802eeb2691396ab8b0812ad09dc8ec5b9d4865cd66112a05b19::colt {
    struct COLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLT>(arg0, 6, b"COLT", b"colt", b"High and mighty shall join the $COLT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241229_051050_399_5cef6e627b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

