module 0xbe23cde7ae93396f80aa250e9c8112b6769168e338fb1434cf7cc79ab20286f9::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"065355494d414e0b54484520535549204d414eae0143616c6c65642062792068747470733a2f2f782e636f6d2f437962756e5f4167656e742076696120404f7572626c617374626f742022404f7572626c617374626f742043726561746520746f6b656e204e616d65203a2054484520535549204d414e207469636b6572203a20245355494d414e20444f20594f55204c494b4520544849532050494354203f2040456d616e4162696f2068747470733a2f2f742e636f2f487339615a4458623967222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f48544a5066416a61494141327959432e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

