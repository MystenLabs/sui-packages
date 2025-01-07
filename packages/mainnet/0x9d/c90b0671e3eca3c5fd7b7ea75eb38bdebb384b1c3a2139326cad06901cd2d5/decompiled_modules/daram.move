module 0x9dc90b0671e3eca3c5fd7b7ea75eb38bdebb384b1c3a2139326cad06901cd2d5::daram {
    struct DARAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARAM>(arg0, 6, b"Daram", b"Daughter's dream", b"His three-year-old daughter is painting. I say this is a duck and she says this is a goose. So is this a duck or a goose?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241012092720_210f1438c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

