module 0x7799b24b84d0533300b6f85b57163ae37e2edf8b1a469b082533cd5dce9f855e::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"075355495255544f0753756972757475567c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f7375697275746f6d656d65706f7274616c222c2274776974746572223a2268747470733a2f2f782e636f6d2f7375697275746f5f6d656d65227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f65356162643237353739316439383034303164346362383261313361623266332e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

