module 0x9741ecdcbc1cba16b32cb6b5017ebbf4a24c912aa8dbca865da31c102b9eda5b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034341540b53696d6f6e277320436174c801546865204f726967696e616c20437572696f7573204361740a0a73696d6f6e206361743f0a6e6f2074686f75676874732e0a6a7573742073696d6f6e2e0a4f6e65204361742e2042696c6c696f6e73206f66204f776e6572732e20416c726561647920646f6d696e6174696e6720424e42202620534f4c20e28094206e6f77206f6666696369616c6c79206c61756e6368696e67206f6e205355492045636f53797374656d2e2054686520636f6e66757365642063617420676f6573206d61696e73747265616d2e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f33383835613132393965653738383436343339316334353336343565323632322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

