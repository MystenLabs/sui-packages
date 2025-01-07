module 0x43e285c873041e1638881cc78482353ba9f8e0ee800d90f02b222d35ea53ba33::xrps {
    struct XRPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRPS>(arg0, 6, b"XRPS", b"XRPSniper", b"Fastest trading bot on XRP by SUITE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_02_06_57_15_c1898eec15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

