module 0xaa787df080aa3a1f40a106a6f1a2b8b9a40a70d294b75d3dd62380265c03bfd::hkdk {
    struct HKDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKDK>(arg0, 9, b"HKDK", x"e6b8afe5b881", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreifc7glylbyc7l3nhh6vow44tilzqz77f442sg7v6ye3gfgxeoakim")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HKDK>>(0x2::coin::mint<HKDK>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKDK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKDK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

