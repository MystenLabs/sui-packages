module 0x6043a07004eb0f66019ba790b9b80f7aad5cc512a303db197b37811aae1e0b80::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/25af844a-4289-4172-b5ed-3b0c3bae36bd/file-y7CE78boJgdkDbE65XLGxQwi.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/25af844a-4289-4172-b5ed-3b0c3bae36bd/file-y7CE78boJgdkDbE65XLGxQwi.webp"))
        };
        let v1 = b"a$SUPEN";
        let v2 = b"bSUPE TOKEN";
        let v3 = x"6324535550454e2069732061206d656d6520636f696e2077697468206120756e69717565207468656d6520696e737069726564206279206120666f7267657466756c206361742e205769746820746865206d697373696f6e20746f202274616b65206120627265616b222066726f6d2074686520687573746c6520616e6420627573746c65206f662074686520696e766573746d656e7420776f726c642c2024535550454e206973206865726520746f2068656c7020696e766573746f727320686f646c20776974686f7574207374726573732e205468697320636f696e20696e766974657320796f7520746f20656e6a6f7920746865206a6f75726e657920776974686f757420636f6e7374616e746c7920636865636b696e6720746865206d61726b6574206f72206d6f6e69746f72696e67206368617274732e0d0a0d0a";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

