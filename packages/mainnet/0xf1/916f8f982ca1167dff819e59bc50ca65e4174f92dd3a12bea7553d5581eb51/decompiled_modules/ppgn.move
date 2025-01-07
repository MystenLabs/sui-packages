module 0xf1916f8f982ca1167dff819e59bc50ca65e4174f92dd3a12bea7553d5581eb51::ppgn {
    struct PPGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPGN>(arg0, 6, b"PPGN", b"PEPPY PIGEON", b"Flying high with endless energy, Peppy Pigeon is delivering meme gold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_031637890_5e94945de1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

