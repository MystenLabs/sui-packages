module 0x55c22e193dd0c376d66c8fd5d230f754b3ac130a69388181f14fb550230d3c20::trumpbull {
    struct TRUMPBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPBULL>(arg0, 6, b"TRUMPBULL", b"TRUMPBULL COIN", x"496e74726f647563696e67205452554d5042554c4c2c20746865207265766f6c7574696f6e617279206d656d65636f696e2074686174206272696e677320746f6765746865722074776f206f6620746865206d6f737420706f70756c6172206d65746173206f6e2074686520626c6f636b636861696e3a205472756d7020616e642042756c6c697368210a68747470733a2f2f7472756d7062756c6c2e66756e2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722176184327_528ecf06390761b878185e3cb2c3ff30_192395a61a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

