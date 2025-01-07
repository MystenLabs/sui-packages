module 0xafe320925f21c171f3406d70881700ce43772242a70e2816f379954a518458d5::bube {
    struct BUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBE>(arg0, 6, b"BUBE", b"BubbleVerse", x"4561636820627562626c6520686f6c64732076616c75652c206275742063616e20627572737420617420616e79206d6f6d656e742c2072656c656173696e67206974732076616c756520746f2074686520636f6d6d756e6974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241014_110601_572_f12b0c6ec0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

