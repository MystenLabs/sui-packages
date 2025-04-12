module 0xbdbcdf285cda452f3f111577a06c313d6b22e7d4a88c0b14cad093ed46790688::pugg {
    struct PUGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGG>(arg0, 6, b"PUGG", b"Pugg", x"24505547472069732074686520666f72676f7474656e2c20726574617264656420667269656e64206f662050657065200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4qtt_Zpoa_400x400_fe553640da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

