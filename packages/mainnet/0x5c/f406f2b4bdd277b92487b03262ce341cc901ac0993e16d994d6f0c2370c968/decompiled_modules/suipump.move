module 0x5cf406f2b4bdd277b92487b03262ce341cc901ac0993e16d994d6f0c2370c968::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0653554947454d0653756947656d8d01f09f928e2053756947656d207c202447454d0af09f8eae205468652047656d206f6620746865205375692047616d650ae29aa1204275696c7420666f72207468652053756920636f6d6d756e6974790af09f9a8020436f6c6c6563742e20486f6c642e204c6574206974207368696e652e0af09f928e20596f7572206e6578742067656d20697320686572652e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f65656236346163313264646435613262333665353862373866313833613638332e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

