module 0x3db7b312c45bacb56a3d36c9c760eda61fab77278cff43cd5180f897c2f9e94a::justone {
    struct JUSTONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTONE>(arg0, 6, b"Justone", b"1$", b"just buy 1$ worth of this coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000260419_11af68393d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

