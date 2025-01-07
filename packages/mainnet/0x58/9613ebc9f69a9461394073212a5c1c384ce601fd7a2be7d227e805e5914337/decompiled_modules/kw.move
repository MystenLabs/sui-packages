module 0x589613ebc9f69a9461394073212a5c1c384ce601fd7a2be7d227e805e5914337::kw {
    struct KW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KW>(arg0, 9, b"KW", b"GBCMOBILE", b"GBC is the first Arab pioneering company to innovate in the field of providing services", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gbcmobile.com/en/")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KW>>(v2, @0x54797ad359f59b512c6a4089d0946fb0ee179bbe175edbda470df5d1ff4dd9b8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KW>>(v1);
    }

    // decompiled from Move bytecode v6
}

