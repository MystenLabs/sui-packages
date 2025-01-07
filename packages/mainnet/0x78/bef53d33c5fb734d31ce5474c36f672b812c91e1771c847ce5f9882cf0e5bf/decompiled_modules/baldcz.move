module 0x78bef53d33c5fb734d31ce5474c36f672b812c91e1771c847ce5f9882cf0e5bf::baldcz {
    struct BALDCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDCZ>(arg0, 6, b"BaldCZ", b"BaldCZ On Sui", b"CZ will be released today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_82_cf57af171b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALDCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

