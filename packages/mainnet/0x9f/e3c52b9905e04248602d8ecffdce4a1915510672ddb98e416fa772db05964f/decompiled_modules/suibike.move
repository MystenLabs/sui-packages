module 0x9fe3c52b9905e04248602d8ecffdce4a1915510672ddb98e416fa772db05964f::suibike {
    struct SUIBIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIKE>(arg0, 6, b"SUIBIKE", b"GO BIKE ME", b"By cycling from one point to another, users get a reward in $SUIBIKE, also be able to become movement for a healthy lifestyle. #RideToEarn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_09_23_42_29_ee9b73b1e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

