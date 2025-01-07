module 0x390c3734d7692a8b9ec8983c4d61054cf7d26b160665d7c938d16fc521cc1a6b::ryoshi {
    struct RYOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYOSHI>(arg0, 6, b"RYOSHI", b"Ryoshi", x"52796f73686920636f6d696e6720696e746f207375692c205468652053686962612041726d79206973206865726520746f206d616b652061206e657720686973746f727920616e64206d616b6520737569206d656d6520666c79696e672066757274686572200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731157530745.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RYOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYOSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

