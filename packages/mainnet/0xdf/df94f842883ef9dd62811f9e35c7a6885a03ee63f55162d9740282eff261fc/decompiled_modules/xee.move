module 0xdfdf94f842883ef9dd62811f9e35c7a6885a03ee63f55162d9740282eff261fc::xee {
    struct XEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEE>(arg0, 6, b"XEE", b"xee  silver", b"06 . 06 . TWO 0 TWO 6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/32_364dfa9d6e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

