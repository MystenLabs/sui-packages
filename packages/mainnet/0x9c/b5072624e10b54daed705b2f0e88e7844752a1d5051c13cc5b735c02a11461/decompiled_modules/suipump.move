module 0x9cb5072624e10b54daed705b2f0e88e7844752a1d5051c13cc5b735c02a11461::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04504154480c504154482054524144494e47e2014f6e652056656e756520746f20747261646520746f6b656e697a65642073746f636b732c2070657270732c206f7074696f6e732c20616e6420616e7920636f696e202d20506f776572656420627920245355490a0a68747470733a2f2f706174682e74726164696e672f6d61726b6574737c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f706174685f69735f686572653f733d313126743d53362d79755239395672747437644d31544e566f6741222c2277656273697465223a2268747470733a2f2f706174682e74726164696e672f6d61726b657473227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f34623634623562356663376565353031636638643165353963343834653634302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

