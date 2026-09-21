module 0x669c600cf17c5e47e63c209eb73c5461676320a66d03fd05a7144836186a2d7d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03444f473853756920446f67206f7220636865636b20424c41535420707269636520e280942049206c6c2074616b652069742066726f6d207468657265ca0143616c6c65642062792068747470733a2f2f782e636f6d2f4f7572626c617374626f742076696120404f7572626c617374626f742022406f6c617264656d6973313333372040426c617374646f747632204053756950756d705f53554d5020486579212049206469646e277420717569746520636174636820746861742e205472792022406f7572626c617374626f74206c61756e63682024444f472053756920446f6722206f722022636865636b20424c4153542070726963652220e280942049276c6c2074616b652168747470733a2f2f6f7572626c6173742e78797a2f69636f6e2d3139322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

