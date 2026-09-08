module 0x4be1e60c682dcfa573c493ac4338b3984e7c6c372226d392aacee8bf7155a7f4::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044152455308417265732d525047f20157656233204d4d4f5250472031303025206f6e205375694e6574776f726b0a2e204578706c6f7265206d756c7469706c6520776f726c64732c20626174746c652068756e6472656473206f66206d6f6e73746572732c206c6f6f7420706f77657266756c20676561722c20636f6e7175657220686172642064756e67656f6e732c20616e642074726164652077697468206f74686572732e7c7c7b2274656c656772616d223a22617265737270672e776f726c64222c2274776974746572223a2268747470733a2f2f782e636f6d2f41726573525047222c2277656273697465223a22617265737270672e776f726c64227d2068747470733a2f2f692e696d6775722e636f6d2f464876493630762e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

