module 0x31a223e130003587a3ad41abb47fd42dee1b54f5950c8d85e3a1975aaeb4782b::dribble {
    struct DRIBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIBBLE>(arg0, 6, b"Dribble", b"SuiDribble", b"Messy, unpredictable, and dripping with potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_045552839_40559f98df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

