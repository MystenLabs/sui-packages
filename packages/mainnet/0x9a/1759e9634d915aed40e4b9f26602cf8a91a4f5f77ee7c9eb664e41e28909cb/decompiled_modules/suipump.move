module 0x9a1759e9634d915aed40e4b9f26602cf8a91a4f5f77ee7c9eb664e41e28909cb::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06535549534849095375697368696361744653757368692043617420537569736869636174206d656f772061726520616c736f20636174206d656d6520746f6b656e7320696e20746865205375692065636f73797374656d6268747470733a2f2f696d672e62677374617469632e636f6d2f6d756c74694c616e672f696d6167652f736f6369616c2f3238626436616333643961396266336262393032326534366638353637316238313732383338343030323835312e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

