module 0xb0857f26947ea3cf923f347b9563a0cfa5b333b8758373652afec40a1a2a287::park {
    struct PARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARK>(arg0, 6, b"PARK", b"SouthParkSui", b"$PARK is the place where all the memecoin legends live together and have fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/park_5f0f040390.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

