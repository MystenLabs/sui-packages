module 0xeee75b6da4e6a97edb54a336a169948e3aeee1157b2f455763b7b223e496d71c::hoprug {
    struct HOPRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPRUG>(arg0, 6, b"HOPRUG", b"Hop Rugged", b"An honest reaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949277681.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPRUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPRUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

