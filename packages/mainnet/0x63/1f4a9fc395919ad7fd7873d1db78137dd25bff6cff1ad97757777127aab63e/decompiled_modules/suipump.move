module 0x631f4a9fc395919ad7fd7873d1db78137dd25bff6cff1ad97757777127aab63e::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04464953480446495348f7014669736820697320612074696e792066697368207377696d6d696e67207468726f75676820746865207661737420537569206f6365616e2e204e6f2070726f6d697365732c206e6f20636f6d706c6963617465642073746f7279206a757374206120636f6d6d756e697479206669736820726964696e67207468652077617665732c20666c6f77696e672077697468206c69717569646974792c20616e642067726f77696e6720616c6f6e677369646520746865205375692065636f73797374656d2e20536d616c6c20666973682e20426967206f6365616e2e204269676765722077617665732e20545553554d49f09f92a7f09f8c8a2068747470733a2f2f692e696d6775722e636f6d2f73416731396f722e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

