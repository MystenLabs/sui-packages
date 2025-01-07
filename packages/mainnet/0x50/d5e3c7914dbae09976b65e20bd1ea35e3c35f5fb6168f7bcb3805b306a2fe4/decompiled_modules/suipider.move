module 0x50d5e3c7914dbae09976b65e20bd1ea35e3c35f5fb6168f7bcb3805b306a2fe4::suipider {
    struct SUIPIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIDER>(arg0, 6, b"SUIPIDER", b"SUIPIDERMAN", x"57656c636f6d6520746f2053554950494445522d4d414e0a4b696e67206f66207468652053554920535741470a0a57697468206772656174204d454d4520636f6d657320677265617420726573706f6e736962696c6974792e0a2d756e636c652062656e2d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_2_4b35e3a693.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

