module 0xea3e15088a87c917056dc9d2bdaed4cfacd116a1ec80f2d6f42833ffd34df0be::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0557415445520557617465729401546865206e616d6520225375692220636f6d65732066726f6d20746865204a6170616e65736520776f726420666f722077617465722028e6b0b4292c2063686f73656e206265636175736520746865206e6574776f726b2773206172636869746563747572652069732064657369676e656420746f20626520666c7569642c20616461707461626c652c20616e6420666173742e2068747470733a2f2f692e696d6775722e636f6d2f4a6e70505766422e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

