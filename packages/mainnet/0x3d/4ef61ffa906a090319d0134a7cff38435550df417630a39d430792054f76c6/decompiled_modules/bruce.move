module 0x3d4ef61ffa906a090319d0134a7cff38435550df417630a39d430792054f76c6::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 6, b"Bruce", b"Bruce The Shark", x"42727563652074686520677265617420776869746520736861726b206973206865726520746f206465766f757220616c6c2074686520736d616c6c206669736820696e2074686520537569206f6365616e2e200a0a466973682061726520666f6f642c206e6f7420667269656e64732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730817319618.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

