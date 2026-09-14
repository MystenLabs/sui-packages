module 0x956274ccc1ea33cddcf341ff6866adaf17dacd9cec6ee2d968cdbdcffb8dd757::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06454e47494e450e454e47494e45202fe998b4e88c8ea50241207472656e64696e6720636c6970206f6e205820666561747572696e672061204368696e65736520206c6164792073696e67696e67206120736f6e672077686572652074686520776f72642022656e67696e65222070686f6e65746963616c6c7920736f756e646564206c696b6520746865204368696e65736520776f726420e998b4e88c8e202870656e6973292c207475726e696e6720612073696d706c6520766f63616c20747261636b20696e746f20616e20696e7374616e7420766972616c206d656d65206163726f737320736f6369616c206d656469612e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f437265656b73686974696e446177732f7374617475732f32303938303938353938303732353136393236227d2068747470733a2f2f692e696d6775722e636f6d2f6a687156635a382e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

