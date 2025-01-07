module 0x7739d1593c03a54d793fd0d8214a5dc6d7365e5944e8ba1a4cf0ea1e5d4a70b2::balek {
    struct BALEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALEK>(arg0, 6, b"BALEK", b"balek", b"menbabibi on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bruh_570218f283.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

