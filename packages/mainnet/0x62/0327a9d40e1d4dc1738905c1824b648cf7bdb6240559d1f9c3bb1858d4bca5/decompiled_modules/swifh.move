module 0x620327a9d40e1d4dc1738905c1824b648cf7bdb6240559d1f9c3bb1858d4bca5::swifh {
    struct SWIFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIFH>(arg0, 9, b"SWIFH", b"Suiman Wif Hat", b"the suiman wif hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWIFH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIFH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

