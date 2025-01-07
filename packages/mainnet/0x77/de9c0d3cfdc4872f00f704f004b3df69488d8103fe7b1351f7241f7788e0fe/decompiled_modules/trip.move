module 0x77de9c0d3cfdc4872f00f704f004b3df69488d8103fe7b1351f7241f7788e0fe::trip {
    struct TRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIP>(arg0, 6, b"TRIP", b"T-R-I-P", b"Psychedelic Rabbit Trippin' on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_29_at_10_51_43a_am_9165e0872d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

