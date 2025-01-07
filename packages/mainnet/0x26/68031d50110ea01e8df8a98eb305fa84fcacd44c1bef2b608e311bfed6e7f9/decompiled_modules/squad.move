module 0x2668031d50110ea01e8df8a98eb305fa84fcacd44c1bef2b608e311bfed6e7f9::squad {
    struct SQUAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAD>(arg0, 6, b"SQUAD", b"SUI-CIDE SQUAD", x"5355492d43494445202453515541442e20206a6f696e207468652063756c742020687474703a2f2f742e6d652f6369646573717561645f7375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_CIDE_SQUAD_a3b111ae1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

