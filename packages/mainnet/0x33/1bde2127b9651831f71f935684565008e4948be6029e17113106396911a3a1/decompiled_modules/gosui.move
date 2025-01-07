module 0x331bde2127b9651831f71f935684565008e4948be6029e17113106396911a3a1::gosui {
    struct GOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOSUI>(arg0, 6, b"GOSUI", b"GO BIKE SUI", b"By cycling from one point to another, users get a reward in $GOSUI, also be able to become movement for a healthy lifestyle. #RideToEarn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_09_23_42_29_eed9993d72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

