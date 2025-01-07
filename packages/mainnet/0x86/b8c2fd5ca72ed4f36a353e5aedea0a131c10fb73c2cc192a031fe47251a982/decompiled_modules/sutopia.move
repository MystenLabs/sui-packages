module 0x86b8c2fd5ca72ed4f36a353e5aedea0a131c10fb73c2cc192a031fe47251a982::sutopia {
    struct SUTOPIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTOPIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTOPIA>(arg0, 6, b"SUTOPIA", b"SuTopia", b"SuTopia is the place where u can feel safe, from all that's going on in the outside world, we are trying to build a community where we support each other, ad a place where u can let ur thoughts loose and chillax, come join SuTopia and enjoy ur time here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Log_A_2_11f64823c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTOPIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTOPIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

