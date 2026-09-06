module 0xf20a8f54ab4f9ee3caaf6a577a4faaefa0c7ba34a26a9cbf99e7ae16f68288b7::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05504954323706245049543237eb0122426f726e20696e20746865207069742e20526973696e6720746f2074686520746f7020696e20323032372e204e6f20726f61646d61702e204e6f2070726f6d697365732e204a75737420612063796265722070697462756c6c2074686174207265667573657320746f206c657420676f206f662074686520626f6e652e205468652064656570657220697420676f65732c207468652068617264657220697420626974657320616e642070756d70732e2041726520796f7520627261766520656e6f75676820746f20656e7465722074686520706974207769746820746869732070697462756c6c3f222068747470733a2f2f692e696d6775722e636f6d2f70555232504a4f2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

