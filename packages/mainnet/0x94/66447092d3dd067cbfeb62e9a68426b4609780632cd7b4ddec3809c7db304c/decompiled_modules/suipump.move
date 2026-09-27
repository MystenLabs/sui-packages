module 0x9466447092d3dd067cbfeb62e9a68426b4609780632cd7b4ddec3809c7db304c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"065355494e49430c53756970657220536f6e6963d20154686520466173746573742052756e6e6572206f6e2053756920486173204172726976656421205375706572205375696e696320686173206a6f696e656420746865207261636520616e6420697320636f6d6d697474656420746f206275726e696e6720616c6c206c69717569646974792c20656e737572696e672061207361666520616e642073656375726520636f6e747261637420666f7220616c6c2e204a6f696e2074686520245375696e696320636f6d6d756e69747920616e64207769746e6573732074686520667574757265214268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f63383838343839653433653662306532336461333033666462356435323263612e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

