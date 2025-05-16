module 0xdc75a47ec9b05a22fb9a55c1254293ba1ec44a53bc7a7e7ced6bfe0362bae793::flub {
    struct FLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUB>(arg0, 6, b"FLUB", b"Flub The Fish", b"Fish and water, Hand in glove-a perfect mariage with sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070380_37a8480188.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

