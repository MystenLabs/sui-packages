module 0xe4ad5a542e249165448aa978259a820847d55c06bebfa5aa89328efbdc07f65b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"075355494c4c554d0c5355494c4c554d494e4154497b546869732069736e2774206120746f6b656e2e204974277320616e20696e7669746174696f6e2e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f687573746c65746f6b656e73222c2274776974746572223a2268747470733a2f2f782e636f6d2f487573746c655f546f6b656e5f4270227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f38613063343139346430303833393933646264346564633365363431356231322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

