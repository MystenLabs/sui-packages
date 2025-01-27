module 0xbdbba2173d51851c2549571adba956a012235f4b10aaa1bd33e762ad8dab8e16::ella {
    struct ELLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELLA>(arg0, 6, b"ELLA", b"ELLA ON SUI", x"54686520686f72726f7220626567696e73e280a620f09f9181efb88fe2808df09f97a8efb88ff09f92800a0a454c4c41206973206e6f74206a75737420616e6f74686572206d656d65202d20736865e28099732061206e696768746d6172652e2041206861756e74696e672070726573656e6365206c75726b696e67206f6e205375692c20726561647920746f207368616b652074686520636861696e207769746820746572726f7220616e6420766f6c756d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737999817451.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

