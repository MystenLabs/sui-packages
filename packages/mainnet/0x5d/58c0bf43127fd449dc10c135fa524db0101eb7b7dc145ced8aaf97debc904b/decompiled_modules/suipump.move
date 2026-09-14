module 0x5d58c0bf43127fd449dc10c135fa524db0101eb7b7dc145ced8aaf97debc904b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044d4f4557074d6f6577737569a1014d656f77537569206973206120706c617966756c206361742d696e737069726564206d656d652070726f6a65637420626f726e206f6e20746865205375692065636f73797374656d2c20636f6d62696e696e672074686520737065656420616e6420746563686e6f6c6f6779206f662053756920776974682074686520756e73746f707061626c6520656e65726779206f6620696e7465726e657420636174732e3468747470733a2f2f706e67696d672e636f6d2f75706c6f6164732f7075736865656e2f7075736865656e5f504e4734332e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

