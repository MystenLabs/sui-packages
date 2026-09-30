module 0xe45f8529a3b1bbd49896f4bbcd299ecd6df753948e2a2ecfa6c9995297085dfa::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"024f32064f787967656eec014f3220697320746865206261736520756e6974206f662074686520427265617468652045636f6e6f6d79206f6e205375692e0a0a4265666f7265206d61726b6574732c206265666f7265206d6f76656d656e742c206265666f72652076616c75653a206272656174682e0a0a4f787967656e206265636f6d657320656e657267792e20456e65726779206265636f6d657320666c6f772e20466c6f77206265636f6d65732076616c75652e0a0a53696d706c652e204c69717569642e20436f6d706f7361626c652e20416c6976652e0a0a4f3220e28094206c6966652c206d6f76696e67206f6e205375692e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f65663630653861626637343030636462626331396262633338393036383266642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

