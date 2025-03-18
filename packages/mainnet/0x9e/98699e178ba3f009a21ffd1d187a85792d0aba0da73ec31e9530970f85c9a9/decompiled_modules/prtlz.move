module 0x9e98699e178ba3f009a21ffd1d187a85792d0aba0da73ec31e9530970f85c9a9::prtlz {
    struct PRTLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRTLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRTLZ>(arg0, 6, b"PRTLZ", b"Portalz", x"54686520506f7274616c206973206f70656e696e672e2e2e2041726520796f752072656164793f0a5374657020696e2e204c6576656c2075702e20506f7274616c7a206177616974206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_48f7ffc3c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRTLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRTLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

