module 0xf5955b6ef63c09c2c6052cebb1b23194356b034543ed39b9b924c679909fbdd2::sprise {
    struct SPRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRISE>(arg0, 6, b"SPRISE", b"SUIrprise", b"Enjoy the SUIrprise!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGOSUIPRISE_4d6b0e46bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

