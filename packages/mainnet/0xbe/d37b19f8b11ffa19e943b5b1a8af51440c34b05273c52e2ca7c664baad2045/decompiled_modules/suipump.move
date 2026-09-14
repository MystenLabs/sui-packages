module 0xbed37b19f8b11ffa19e943b5b1a8af51440c34b05273c52e2ca7c664baad2045::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044449454d044469656df1015468652053756920626c6f636b636861696e20776173206275696c742066726f6d2073637261746368206279204d797374656e204c61627320616e6420646964206e6f742073696d706c7920696e686572697420612070726576696f7573206e616d652c206275742069747320636f72652063726561746f727320616e6420746563686e6f6c6f6779207472616365207468656972206f726967696e73206261636b20746f204d6574612773202846616365626f6f6b29206162616e646f6e6564204469656d2070726f6a6563742c20776869636820776173206f726967696e616c6c79206e616d6564204c696272612e2068747470733a2f2f692e696d6775722e636f6d2f355330716673552e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

