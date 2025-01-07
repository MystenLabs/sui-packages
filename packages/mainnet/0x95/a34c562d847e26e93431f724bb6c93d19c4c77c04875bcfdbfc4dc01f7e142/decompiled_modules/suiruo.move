module 0x95a34c562d847e26e93431f724bb6c93d19c4c77c04875bcfdbfc4dc01f7e142::suiruo {
    struct SUIRUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUO>(arg0, 9, b"SUIRUO", b"Smiling Dolphin Suiruo", b"The dolphin on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.geckoterminal.com/_next/image?url=https%3A%2F%2Fassets.geckoterminal.com%2F5g9gc6j0dzu893v111ocxv8ujnca&w=32&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRUO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

