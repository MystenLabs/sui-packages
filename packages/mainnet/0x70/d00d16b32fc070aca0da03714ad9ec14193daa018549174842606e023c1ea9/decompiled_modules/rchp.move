module 0x70d00d16b32fc070aca0da03714ad9ec14193daa018549174842606e023c1ea9::rchp {
    struct RCHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCHP>(arg0, 6, b"RCHP", b"Rachop", x"24526163686f702053756920616e6420687474703a2f2f486f702e66756e20666972737420526163636f6f6e0a40486f7041676772656761746f720a202c200a405375694e6574776f726b0a0a57697468206d792062756e6e79206279206d7920736964652c20526163686f7020616e6420492074616b652074686520726964652c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002902917.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCHP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCHP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

