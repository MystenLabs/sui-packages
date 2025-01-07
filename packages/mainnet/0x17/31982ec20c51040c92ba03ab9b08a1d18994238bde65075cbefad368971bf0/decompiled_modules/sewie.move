module 0x1731982ec20c51040c92ba03ab9b08a1d18994238bde65075cbefad368971bf0::sewie {
    struct SEWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEWIE>(arg0, 6, b"SEWIE", b"Suibacca", b"The only known blue wookie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3653479203917463330_553e3bd80f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEWIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEWIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

