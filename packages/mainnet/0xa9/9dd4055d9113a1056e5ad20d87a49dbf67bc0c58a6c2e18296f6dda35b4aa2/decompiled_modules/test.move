module 0xa99dd4055d9113a1056e5ad20d87a49dbf67bc0c58a6c2e18296f6dda35b4aa2::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"TEST", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/016ae013-3ef0-4999-b908-bcfb502189c6.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

