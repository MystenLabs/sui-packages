module 0x5dc60c7622d02977606f73576edea71f7c2a6ceb7406a74b2cd69c2c97ba09bf::axol {
    struct AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOL>(arg0, 6, b"Axol", b"AXOL", x"546865204f472041584f4c204953204241434b210a0a496e74726f647563696e672041786f6c207468652061786f6c6f746c2c20746865206d656d6520746861742077696c6c206c69746572616c6c79206d616b6520796f7520736d696c652065617220746f206561722e2041786f6c2069732074686520446567656e7320647265616d3a207061727420637574652c20706172742077656972642c20616e64203130302520706f74656e7469616c20746f206d6f6f6e2e2041786f6c6f746c7320726567656e65726174652c20616e6420736f2063616e20796f757220626167732077697468207468697320746f6b656e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/axol_logo_1176f5dd0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

