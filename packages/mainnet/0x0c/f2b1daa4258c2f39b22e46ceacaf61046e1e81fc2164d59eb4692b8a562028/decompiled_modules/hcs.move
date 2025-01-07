module 0xcf2b1daa4258c2f39b22e46ceacaf61046e1e81fc2164d59eb4692b8a562028::hcs {
    struct HCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCS>(arg0, 6, b"HCS", b"HopCatSui", b"First cat on Hop Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hop_cat_22df7531b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

