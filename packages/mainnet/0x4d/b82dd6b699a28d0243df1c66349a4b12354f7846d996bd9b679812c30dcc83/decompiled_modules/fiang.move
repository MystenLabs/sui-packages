module 0x4db82dd6b699a28d0243df1c66349a4b12354f7846d996bd9b679812c30dcc83::fiang {
    struct FIANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIANG>(arg0, 6, b"FIANG", b"Fish Angry", b"When the market dips, Angry Fish just gets angrier... and so do the profits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_152317_9e451f07fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

