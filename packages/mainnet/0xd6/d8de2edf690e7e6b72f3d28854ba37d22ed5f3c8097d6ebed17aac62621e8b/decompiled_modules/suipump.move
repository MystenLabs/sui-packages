module 0xd6d8de2edf690e7e6b72f3d28854ba37d22ed5f3c8097d6ebed17aac62621e8b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0353414d0e53616d20426c61636b73686561729f014d545320617420416e7468726f7069632e2043726561746f72206f66204d6f7665206c616e672c20636f2d666f756e6465722f666f726d65722043544f206f66204d797374656e204c6162732028537569206e6574776f726b292c2065782073746174696320616e616c79736973206174204d6574612e0a5c7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f623161636b643067227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f323039343632373735343233353038343830302f7532372d765230335f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

