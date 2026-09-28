module 0xc98d4ad634708defc49cbb917a3ebfd50b847fddbc2a50f511a99f98a1a7391::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06504550434154085065706520436174c401504550434154206973206120677265656e20696e7465726e657420636174206f6e205355492045636f73797374656d2e20426967206772696e2c20676c6f73737920657965732c206e6f20636f6d706c696361746564206261636b73746f72792e0a0a426f726e2066726f6d206d656d652063756c7475726520616e64206b657074206d6f76696e67206279207468652070656f706c652077686f2067657420746865206a6f6b652e20536f6d6574696d657320612063617420697320656e6f7567682e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f38653231313433623433633361613131313137326436643932633162656238302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

