module 0x18835c7d307283de6f47004b2fe04f35f90f2ed0af41debd4af5f7fb3a189bbb::waterr {
    struct WATERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERR>(arg0, 6, b"WATERR", b"WATER", x"4845592c49276d20574154455252207375706572207374726f6e67206a757374206c696b65206d79206672656e2073756920f09f92a7f09f92a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731325439748.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATERR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

