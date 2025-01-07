module 0x6cb4778c307dd81083c08980089c950e2fff60e495545d62e4c2f597c2aa4d5c::avaai {
    struct AVAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAAI>(arg0, 6, b"AVAAI", b"THE AVA AI", b"Ava is an AI trained by the community, evolving with each interaction. Once complete, it will become a powerful model for everyone to use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2222_e7625b2f03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

