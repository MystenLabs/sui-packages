module 0x33f183213b12e1e296cf40f7801fa90584ee35dda6d9b1a1a83e298c654d879e::times {
    struct TIMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMES>(arg0, 6, b"TIMES", b"DarkTimes", x"706c61796461726b74696d65732e636f6d202d204261636b656420627920416e696d6f63614272616e6473202b206275696c7420627920416e696d6f636173205649502067616d652073747564696f20426c6f776669736853747564696f732e204f6666696369616c2066616972206c61756e63682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Umr_Qhyb_Y_400x400_6c41091817.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

