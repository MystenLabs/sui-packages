module 0x4e73cc0cce292fbe57117cbf3048ee7a9a2b506eb5b73183e66aa51bad90e65e::gfish {
    struct GFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFISH>(arg0, 6, b"GFISH", b"GOLDEN FISH SUI", b"Golden fish good fish narative with gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3903_125576fa45.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

