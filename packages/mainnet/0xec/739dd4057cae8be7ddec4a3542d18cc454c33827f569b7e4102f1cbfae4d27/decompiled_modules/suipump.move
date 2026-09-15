module 0xec739dd4057cae8be7ddec4a3542d18cc454c33827f569b7e4102f1cbfae4d27::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"09534841524b5355494909536861726b73756969ce01f09fa6882043727970746f20536861726b73206f6e2053756920f09f90b30a0a4c617267652053554920686f6c646572732063616e20696e666c75656e6365206c697175696469747920616e64206d61726b6574206d6f76656d656e74732e0af09f92b02054686579206d6179206275792c2073656c6c2c207374616b652c206f722070726f76696465206c69717569646974792e0ae29aa12054686569722061637469766974797c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f73756970756d7031227d4968747470733a2f2f692e6962622e636f2f63536d5171784a622f372d4644332d424143312d4135392d462d342d44392d442d3836352d422d333230373136352d45323939312e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

