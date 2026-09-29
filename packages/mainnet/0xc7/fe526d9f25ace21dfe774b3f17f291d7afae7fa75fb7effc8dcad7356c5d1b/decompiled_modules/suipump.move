module 0xc7fe526d9f25ace21dfe774b3f17f291d7afae7fa75fb7effc8dcad7356c5d1b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05534549524f12536569726f2061204e6569726f2048656972f501546865206c656761637920636f6e74696e7565732e0a200a46726f6d207468652064756e657320616e64206c6567656e6473206f66206f6c642c2061206e657720677561726469616e20726973657320e2809420536569726f2e0a426f726e206f6e205375692c20666f7267656420696e2073706565642c206275696c7420746f206c6561642e0a200a54686520626c6f6f646c696e65206e657665722066616465642e204974206a757374207761697465642e0a200a4865697220746f20746865206e616d652e204865617274206f662074686520636861696e2e205468652066757475726520697320686572652e20f09f9a804268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f34646332386639396330616336376162626231396239663737613761636662372e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

