module 0x62ec4c1b056cd38e2668548d07f8c8a71e9dd8b624999128a61fd823ad5fb701::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"055355494d5506537569204d75b4015468652062756c6c206f66205375692e20496620796f7520636c6f7365206f6e6520657965206865206d69676874206c6f6f6b206a757374206c696b65204164656e6979692e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f4d5553554942554c4c222c2274776974746572223a2268747470733a2f2f782e636f6d2f6d7573756962756c6c222c2277656273697465223a2268747470733a2f2f742e6d652f4d5553554942554c4c227d2068747470733a2f2f692e696d6775722e636f6d2f793945397732612e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

