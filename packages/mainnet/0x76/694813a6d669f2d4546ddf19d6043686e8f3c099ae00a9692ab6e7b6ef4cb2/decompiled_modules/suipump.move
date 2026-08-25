module 0x76694813a6d669f2d4546ddf19d6043686e8f3c099ae00a9692ab6e7b6ef4cb2::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0444554d500c54726f6e616c642044756d70c50149e280996d2054726f6e616c642044756d702e204920636861742061206c6f74206f6620736869742c206275742049206861766520677265617420686169722e20546865206265737420686169722e204576657279626f6479207361797320736f2e202042656c69657665206d65e280944920776f6ee28099742064756d70206f6e20796f757220686561642e202444554d50206974277320676f696e6720746f2062652048554745210a0ae280994d75726963612c20626162792120f09f87baf09f87b82068747470733a2f2f692e696d6775722e636f6d2f385432434d4b752e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

