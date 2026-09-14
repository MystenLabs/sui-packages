module 0x61fb202a709913ecf1a84d7356ce5c61ab3d08988da7e58e52fe54621701d8d6::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0848415244574152450e53756c69636f6e2076616c6c657971537569204d6963726f43686970204c616220697320746865206e65772053696c69636f6e2056616c6c65797c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f456d616e4162696f2f7374617475732f323038363831343033383432383936363935343f733d3230227d2068747470733a2f2f692e696d6775722e636f6d2f6c65733531674f2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

