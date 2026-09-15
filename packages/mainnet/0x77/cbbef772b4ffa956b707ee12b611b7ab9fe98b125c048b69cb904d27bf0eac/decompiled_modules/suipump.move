module 0x77cbbef772b4ffa956b707ee12b611b7ab9fe98b125c048b69cb904d27bf0eac::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"084241534543414d5010535549204241534543414d2032303236d801746869732069732061207369676e206f66205355494e414d492c20456d616e20736169642022205468696e6773207468617420796f75277665206265656e2061736b696e67202220596f75206b6e6f77207768617420646f65732074686973206d65616e732072696768743f204c6574732072756e2074686973206f6e6520616e6420676574207468697320626f6e6465647c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f456d616e4162696f2f7374617475732f323039393737303936343630333032373834323f733d3230227d2068747470733a2f2f692e696d6775722e636f6d2f376f706459744e2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

