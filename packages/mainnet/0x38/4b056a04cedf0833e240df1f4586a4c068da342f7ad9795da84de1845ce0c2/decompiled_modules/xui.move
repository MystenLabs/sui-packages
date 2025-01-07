module 0x384b056a04cedf0833e240df1f4586a4c068da342f7ad9795da84de1845ce0c2::xui {
    struct XUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUI>(arg0, 6, b"XUI", b"Xui Wen Bin", b"Hottest token of the hottest actress", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hui_cc764472f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

