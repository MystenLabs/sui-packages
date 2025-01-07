module 0x950e3ab32ac272f274af0d5896bbe53da240bb90a7cbd230d28952919dcb2c93::sdgold {
    struct SDGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDGOLD>(arg0, 6, b"SDGOLD", b"Swords &amp; Dungeons GOLD", b"GOLD is the best and the  Number 1 Assets Nowadays!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GBOY_8a898e8ac8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

