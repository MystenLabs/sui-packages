module 0xd1f8f310fd096fcf7cbd3c9ce3c893a775a6ca2fc895a55ce67a3469f78ad789::cate {
    struct CATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATE>(arg0, 6, b"CATE", b"Sui Cate", b"New launch following Cate hype and cat meta. This is a version on SUI. Moving well, higher MC play so find good entries in the dip. Links below. Nice branding and ticker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059676_4ee96e3aaa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

