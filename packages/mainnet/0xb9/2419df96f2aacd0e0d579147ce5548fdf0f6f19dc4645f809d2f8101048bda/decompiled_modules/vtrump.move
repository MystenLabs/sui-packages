module 0xb92419df96f2aacd0e0d579147ce5548fdf0f6f19dc4645f809d2f8101048bda::vtrump {
    struct VTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTRUMP>(arg0, 6, b"VTRUMP", b"VOTE TRUMP", b"Token in honor of the tweet and support for Trump: I would like to wish our great Bitcoiners a Happy 16th Anniversary of Satoshis White Paper. We will end Kamalas war on crypto, & Bitcoin will be MADE IN THE USA! VOTE TRUMP! #Bitcoin #FreeRossDayOne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_5_27aa58a3fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

