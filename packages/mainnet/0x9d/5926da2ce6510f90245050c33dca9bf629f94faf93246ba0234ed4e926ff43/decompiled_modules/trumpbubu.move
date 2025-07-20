module 0x9d5926da2ce6510f90245050c33dca9bf629f94faf93246ba0234ed4e926ff43::trumpbubu {
    struct TRUMPBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPBUBU>(arg0, 6, b"TRUMPBUBU", b"Labubu Trump", b"President Trump in its most attention seeking Labubu incarnation. Ready to be nominated for the Noble Peace Prize for his peace efforts. Thank You for Your Attention to This Matter!.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/meme_s_ef29b1a620.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPBUBU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBUBU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

