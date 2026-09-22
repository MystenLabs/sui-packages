module 0x316d9ee6ae7415923a38e2e770d82d7233edf989a442f4bae9ad3e80864fe5e2::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05434f4e534f05436f6e736fbd014e6578742d47656e20436f6e73756d65722052657075746174696f6e204c617965720a506f77657265642062792057616c72757350726f746f636f6c2026205375694e6574776f726b0a436f6d652053756970756d70204e4f570a476f2043657475732077697468696e20323420686f7572737c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f636f6e736f5f78797a222c2277656273697465223a2268747470733a2f2f7777772e636f6e736f2e78797a2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f61326662626439613838323136646438666532383863323433376662666532322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

