module 0x3687d89501f8e169ba71bbfdec4e2d6f0965a24d1ee1e6546b02f26ba4803e4::sherk {
    struct SHERK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHERK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHERK>(arg0, 6, b"SHERK", b"SherkSUI", b"Just a jawsome $SHERK living rent free on #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xw_OEN_Tjh_400x400_7e10dc5380.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHERK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHERK>>(v1);
    }

    // decompiled from Move bytecode v6
}

