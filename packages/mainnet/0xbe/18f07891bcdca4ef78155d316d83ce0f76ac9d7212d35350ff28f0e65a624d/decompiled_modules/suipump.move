module 0xbe18f07891bcdca4ef78155d316d83ce0f76ac9d7212d35350ff28f0e65a624d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"085645524f4e495632075665726f6e69695d5665726f6e696920696e20563220636f6d65206a6f696e2075737c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f57617a7a43727970746f2f7374617475732f32313034313934333037363238363231393736227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f39313461363936373665383165326337643761613437366138366133346532322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

