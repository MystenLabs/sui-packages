module 0xa506cee72905cd21ea1b0236386d5f58dc1598310c29352d197413a5624510f6::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034d4158134d61782028476967676c65204d6173636f74297f476967676c65204d6173636f74204d61782d206665657320676f20746f20476967676c652041636164656d797c7c7b2274656c656772616d223a2268747470733a2f2f7777772e6d6178626e622e6d656d652f222c2274776974746572223a2268747470733a2f2f782e636f6d2f476967676c654d6173636f74424e42227d2068747470733a2f2f692e696d6775722e636f6d2f783536505138622e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

