module 0x624e34e769d1b23679dcbe067e4de807254f582496d1597a39e2d27252715e81::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0343554d0553796261757953796261752043756d636f696e206973207468652067656e6974616c20706c617920796f752068617665206265656e2077616974696e6720666f720a0a4465762077696c6c20646f2061697264726f7020616e642073656e6420746f206d6f6f6e200a0a4465666920616e64204c656e64696e6720736f6f6e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f30363635323863653037356332633966393963313365393732623063336366302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

