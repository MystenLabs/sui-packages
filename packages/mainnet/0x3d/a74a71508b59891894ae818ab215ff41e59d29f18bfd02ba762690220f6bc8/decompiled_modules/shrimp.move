module 0x3da74a71508b59891894ae818ab215ff41e59d29f18bfd02ba762690220f6bc8::shrimp {
    struct SHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMP>(arg0, 9, b"SHRIMP", b"SHRIMP", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://confessionsofafitfoodie.com/wp-content/uploads/2022/12/Air-Fryer-Shrimp-FI-250x250.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHRIMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

