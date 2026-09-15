module 0x458116f9a3e7ec8f91ab804217198082b24636795ea56991b9dff8b9a87944d4::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"054f5242494f084f7262696f2e736fb801546865206d61726b6574706c61636520666f7220636865617020414920637265646974732e203430302b206d6f64656c7320696e636c7564696e6720436c61756465204661626c652c20475054204173747261202d20757020746f20393025206f666620636f6d696e67205355497c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f6f7262696f646f74736f222c2277656273697465223a2268747470733a2f2f7777772e6f7262696f2e736f2f227d5168747470733a2f2f6173736574732e636f696e6765636b6f2e636f6d2f636f696e732f696d616765732f3130323137363636352f7374616e646172642f6f7262696f2e6a70673f31373838343234363630");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

