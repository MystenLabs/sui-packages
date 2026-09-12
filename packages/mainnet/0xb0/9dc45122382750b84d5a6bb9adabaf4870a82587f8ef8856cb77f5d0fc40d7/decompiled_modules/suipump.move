module 0xb09dc45122382750b84d5a6bb9adabaf4870a82587f8ef8856cb77f5d0fc40d7::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05444f47474f0b44616e63696e6720446f676e486520726570726573656e747320646f696e6720796f7572206f776e207468696e672c206265696e6720756e61706f6c6f6765746963616c6c7920796f757273656c662c20616e642073696d706c79206e6f7420636172696e67207768617420616e796f6e65207468696e6b732e1f68747470733a2f2f692e696d6775722e636f6d2f447458465870552e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

