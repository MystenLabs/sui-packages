module 0xf878f9b1e299b7cf374b609871ebdeb67d3fc9666d11bdf22a7b26c715dfbaac::popdog {
    struct POPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDOG>(arg0, 6, b"POPDOG", b"POPDOG SUI", b"The DOG that POPS on SUI. POP POP POP POP !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_Wzz_Q_Vr_G_400x400_356952ef8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

