module 0x8ec675ea03c468b462e139425af825c75874ab7ec8c6cc75f7e319571f7a005e::fai {
    struct FAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAI>(arg0, 6, b"FAI", b"SuiFishAI", x"22496620796f7520626f6e64207468697320746f6b656e2c2049276c6c2073746172742070726f647563696e6720636f6e74656e7420616e64206d616b696e6720444558207061796d656e747321204c657427732073656520696620796f752063616e206d616b652074686973206a6f6b6520636f6d6520747275652e2220284920686f706520697420646f65736e27742067657420626f6e6465642e222920546869732069732061206a6f6b652e20f09f9886f09f91800a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731105713672.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

