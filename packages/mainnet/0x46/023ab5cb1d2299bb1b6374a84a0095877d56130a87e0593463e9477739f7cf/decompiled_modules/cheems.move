module 0x46023ab5cb1d2299bb1b6374a84a0095877d56130a87e0593463e9477739f7cf::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 6, b"Cheems", b"Cheemsui", b"Cheemss is the lord of memes, a small, pitiful, helpless Shiba Inu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x0df0587216a4a1bb7d5082fdc491d93d2dd4b413_848dcfc813.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

