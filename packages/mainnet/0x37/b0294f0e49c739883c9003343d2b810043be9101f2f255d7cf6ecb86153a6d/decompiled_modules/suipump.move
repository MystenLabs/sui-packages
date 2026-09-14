module 0x37b0294f0e49c739883c9003343d2b810043be9101f2f255d7cf6ecb86153a6d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034d4f4e065375696d6f6ec5015375696d6f6e20697320612063756c747572652d66697273742065636f73797374656d20626c656e64696e67206172742c20696e7465726e65742068756d6f722c20616e6420636f6d6d756e6974792e7c7c7b2274656c656772616d223a2268747470733a2f2f742e636f2f396764595a6a7a6a5349222c2274776974746572223a2268747470733a2f2f782e636f6d2f5375696d6f6e5f61745f537569222c2277656273697465223a2268747470733a2f2f7375696d6f6e61747375692e78797a2f227d6868747470733a2f2f656e637279707465642d74626e332e677374617469632e636f6d2f696d616765733f713d74626e3a414e643947635341345a307a5141352d4f35536554347230336e3972316e7474513176526a54694f3958675765526e526d78376b4b346e63");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

