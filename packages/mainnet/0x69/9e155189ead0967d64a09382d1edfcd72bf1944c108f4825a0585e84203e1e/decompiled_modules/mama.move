module 0x699e155189ead0967d64a09382d1edfcd72bf1944c108f4825a0585e84203e1e::mama {
    struct MAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMA>(arg0, 6, b"MAMA", b"MAMASUIII", b"MEME  Oh, I mean suiiiiiiiiiiiiiiiiiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0cb78549426ebe06d2b48d183414be42_1378077f30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

