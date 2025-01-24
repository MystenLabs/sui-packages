module 0x2cb22fd8f3c06f3b8798bb863b8d1338c48001459f35f0950fca50fa995e56e5::shart {
    struct SHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHART, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHART>(arg0, 6, b"SHART", b"SHART COIN by SuiAI", b"I dont think that was a fart....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/poop_72e5522c4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHART>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHART>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

