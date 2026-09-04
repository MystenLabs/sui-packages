module 0xedb1457a51b03719718d66baa33ac6a534a6e38fd3b663f8b80603613088ebe2::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03414d430b41204d656d6520436f696ea801414d43206973206f6e65206f66207468652062696767657374206d6f6d656e747320696e20405375694e6574776f726b20686973746f72792e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f616d656d65636f696e6f6e737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f456d616e4162696f2f7374617475732f323039353734393433313234393538303135323f733d3230227d2068747470733a2f2f692e696d6775722e636f6d2f5a504c6d6b71592e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

