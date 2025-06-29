module 0x3a40780fcf27162600694a5c3296f84d8c8640d65d7cf865c39c1cd77ba272c9::dive {
    struct DIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVE>(arg0, 8, b"DIVE", b"DiverS Token", x"4f6e2d636861696e20706978656c20736375626120646976696e672069646c652067616d65206f6e200a405375696e6574576f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/51ac0368-42cf-43c7-9b8c-9c1aa2345960.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIVE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

