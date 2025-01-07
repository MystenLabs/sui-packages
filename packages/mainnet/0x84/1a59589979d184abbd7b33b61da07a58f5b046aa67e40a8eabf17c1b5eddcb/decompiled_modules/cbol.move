module 0x841a59589979d184abbd7b33b61da07a58f5b046aa67e40a8eabf17c1b5eddcb::cbol {
    struct CBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBOL>(arg0, 6, b"CBOL", b"CAT ON BOWL", b"JUST CAT ON BOWL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/swwswswsw_64782f403d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

