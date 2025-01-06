module 0xea53d3e805ee80910d899b3fcf8a4801a03c25c3e2e37cdb54658ceb5ab552a9::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"Andy", b"Andy on Sui", x"416e6479206f6e2053756920697320612066756e2c20636f6d6d756e6974792d64726976656e20746f6b656e2063656c6562726174696e6720416e64792c2074686520696e7465726e6574e2809973206d6f73742061646f7261626c65206361742e204275696c7420666f722063617420616e642063727970746f206c6f766572732c206974e280997320616c6c2061626f7574206d656d65732c204e4654732c20616e64206a6f792e204a75737420666f722066756ee28094646f20796f757220726573656172636820616e64206f6e6c7920696e76657374207768617420796f752063616e206166666f726420746f206c6f73652120f09f90be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736207237213.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

