module 0xa31411a4759237c015cdd33caeac2016e5f069ba047b3cc0a5f243495c1ef65f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0442495244074269726473756992014120706f77657266756c206269726420696e7370697265642062792074686520537569206e6574776f726b2c2073796d626f6c697a696e672073706565642c2066726565646f6d2c20616e6420696e6e6f766174696f6e2c207769746820676c6f77696e6720626c75652053756920656c656d656e747320616e6420666c6f77696e67206469676974616c20656e657267796d68747470733a2f2f7777772e636c69706172746d61782e636f6d2f706e672f736d616c6c2f36372d3637303931375f616e642d7468652d6d6f74746f2d7365656d65642d6c696b652d69742d7761732d706f696e74696e672d61742d7468652d62697264732d3531322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

