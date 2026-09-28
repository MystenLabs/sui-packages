module 0x5bf4ec1c8796ffcddf83e1dbc37a4270d1727f44c1d42d86c47cb4dbdc6d1066::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"055355494e550753756920496e75b201576f6f6620776f6f662120f09fa6aef09f90b60a0a48656c6c6f2c205375694672656e7321205468697320697320746865207374617274206f66206f7572206a6f75726e657920746f20746865206d6f6f6ef09f8c952e20576527726520696e74726f647563696e67205355494e5520f09f90b62074686520666972737420776f6f66746173746963206d656d652d746f6b656e20746f206578697374206f6e2053756920426c6f636b636861696ee29ca84268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f61386235376436306630366163306261373864363738363364643566666165642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

