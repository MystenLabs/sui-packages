module 0x8eb666b9dad398790835925c119befbca24f02b5958d4a8c679091587b850372::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0743415446495245074361746669726571546865206d6f737420686f7465737420636174206c697665206e6f77206f6e2053756920f09f94a5f09f91917c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f636174666972657375693f733d3131222c2277656273697465223a22636174666972652e66756e227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f63373461656561313431313638316338616636363336393666633435386336642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

