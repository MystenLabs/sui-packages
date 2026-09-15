module 0x2c571f5d750678d95bdd861f42269a270d22652bc4571a0af3da4e4b03dda98d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0452554e540452554e54ba026576657279206c61756e63687061642061736b7320666f72206120746f6b656e20666972737420616e6420612063726f7764206c617465722e0a0a776520666c69707065642069742e206e616d652074686520636f696e2c20736861726520746865206c696e6b2c20616e6420696620796f75722070656f706c652073686f772075702c2074686174277320746865206f6e652074686174206c61756e636865732e0a0a6e6f20746f6b656e20746f206465706c6f792c206e6f2077616c6c65742c206e6f20636f73742e0a0a72756e742e66756e2f7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f72756e7466756e222c2274776974746572223a2268747470733a2f2f782e636f6d2f72756e7466756e222c2277656273697465223a2268747470733a2f2f72756e742e66756e227d2068747470733a2f2f692e696d6775722e636f6d2f3846696f5562762e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

