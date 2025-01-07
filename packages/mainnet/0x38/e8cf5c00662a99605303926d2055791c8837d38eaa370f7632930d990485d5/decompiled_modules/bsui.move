module 0x38e8cf5c00662a99605303926d2055791c8837d38eaa370f7632930d990485d5::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"Make SUI Based Again!", x"4a757374204d454d45206f6e20535549202c206920646f6e7420686f6c642074686520737570706c792c20692068616e64206f7665722074686973207469636b657220746f207468652053554920636f6d6d756e6974792e0a0a4d616b652053554920426173656420416761696e0a4d616b6520535549204865616c74687920416761696e0a4d616b652053554920477265617420416761696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MBSA_e1d55ff45f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

