module 0xe0dcedff61ed6682850823039ae95426a231d8c2f37e20a8c9a4f3fa39cfc8ae::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04504f4d5007504f4d50535549a30157616b652075702c2024504f4d502e2e2e7c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f706f6d707375692f7374617475732f323130333035373431383234323639393639393f733d3436222c2274776974746572223a2268747470733a2f2f782e636f6d2f706f6d70737569222c2277656273697465223a2268747470733a2f2f706f6d707375692e65706f63687375692e636f6d2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f66616531663637366137313733666534656538323735353863383263353761662e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

