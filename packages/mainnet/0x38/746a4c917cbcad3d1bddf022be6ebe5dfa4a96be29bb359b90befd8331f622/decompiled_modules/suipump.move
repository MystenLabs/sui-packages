module 0x38746a4c917cbcad3d1bddf022be6ebe5dfa4a96be29bb359b90befd8331f622::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"064c4f46495441064c6f66697461e001244c4f46495441206973207468652077696665206f66204c6f66692e0a416c6c2074726164696e6720666565732066726f6d20244c4f464954412077696c6c206265207472616e7366657272656420746f20746865204c6f666920466f756e646174696f6e2077616c6c65742e0a0a244c4f4649544120e28094204c6f6669e280997320576966652e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b464f4d73743073435765396a4d574931222c2274776974746572223a2268747470733a2f2f782e636f6d2f4c6f6669746173756970756d70227d2068747470733a2f2f692e696d6775722e636f6d2f426175455972462e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

