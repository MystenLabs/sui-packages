module 0x625ca4204ca41f40abda40bcf60be84fc9cb45b4b85918f319bdc868f6a9ac8b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"085a4550424f554e440c5a4550424f554e4420494e55a801737469636b20697420696e2075722077616c6c65742e20766572792073637261776e2e206d75636820736b696e6e2e7c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f7a6570626f756e645f696e75222c2274776974746572223a2268747470733a2f2f782e636f6d2f7a6570626f756e645f696e75222c2277656273697465223a2268747470733a2f2f782e636f6d2f7a6570626f756e645f696e75227d2068747470733a2f2f692e696d6775722e636f6d2f787746434b42442e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

