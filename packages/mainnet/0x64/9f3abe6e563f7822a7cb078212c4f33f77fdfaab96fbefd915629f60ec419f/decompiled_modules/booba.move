module 0x649f3abe6e563f7822a7cb078212c4f33f77fdfaab96fbefd915629f60ec419f::booba {
    struct BOOBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBA>(arg0, 6, b"Booba", b"Booba?", b"Soft!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_94cbc7fb41.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

