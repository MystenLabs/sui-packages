module 0x64a54dc11aef5d95f64c488d72319a4a0fd1d8d30e919bbfdd79411857847fd4::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"08504f4b45434f494e08504f4b45434f494e08504f4b45434f494eaf0168747470733a2f2f696d616765732e70756d702e66756e2f636f696e2d696d6167652f4741446a384a513869514c51443553365363766e634a576d477337506b77486e5873427245556e73367565353f76617269616e743d3830783830267372633d6874747073253341253246253246676174657761792e697279732e78797a25324646335132536e387150514c6a4671754b727358553870654772464e4466466b53646559766459783459546d48");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

