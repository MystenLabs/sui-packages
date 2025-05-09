module 0x456dd581df9100251c33d61fac790dd6b04391d37ddd43a5cf375f173e75bde0::muttski {
    struct MUTTSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTTSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTTSKI>(arg0, 6, b"MUTTSKI", b"Muttski Dog", b"Muttski, a go-to companion for every trader. A memecoin powered by utility and community engagement, Muttski offers a range of practical tools to enhance your trading experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067876_e8ae84e120.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTTSKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTTSKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

