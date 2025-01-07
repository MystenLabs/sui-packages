module 0xdea7d3c25275db2df1fe96203616cec3ed497101d22556bbbf954566e3d44368::suitch {
    struct SUITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITCH>(arg0, 6, b"SUITCH", b"suitch", b"build suitch on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUITCH_logo_195663eef5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

