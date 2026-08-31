module 0xb4e7024fa2d7ec68a10690b3269bf495896ba8a30c7ad4ec90f536f4cd3e8a8b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034b4d46084b6d66617973616cbb01426f726e2066726f6d206d656d65732c20706f77657265642062792074686520636f6d6d756e6974792c20616e642064726976656e20627920707572652076696265732e204b6d46206973206d6f7265207468616e206a7573742061206d656d65e280946974e28099732061206d6f76656d656e7420666f722065766572796f6e652077686f206c6f7665732063727970746f2c206368616f7320616e642063686173696e6720746865206e65787420626967206d6f6d656e742e2068747470733a2f2f692e696d6775722e636f6d2f5451534a554c562e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

