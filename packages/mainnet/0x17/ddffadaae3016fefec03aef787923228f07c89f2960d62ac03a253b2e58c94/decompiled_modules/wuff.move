module 0x17ddffadaae3016fefec03aef787923228f07c89f2960d62ac03a253b2e58c94::wuff {
    struct WUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUFF>(arg0, 6, b"WUFF", b"WUFF WUFF", b"WUFF WUFF WUFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_14_ad432216c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

