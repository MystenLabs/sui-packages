module 0x16803b5d3ccd6d02719e5ab4e5455804e345264eff289b158c77be7c8aa85231::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 6, b"wSUI", b"SUI PUMP", b"COMMUNITY TAKE OVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2f14b542_f3e5_4e14_95ae_e0c9a23d4b5e_637cb5b0bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

