module 0x603b37aaae4db97abfee36794d71aca5e4755d515cb0e89de1d33075980eaa14::grunt {
    struct GRUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUNT>(arg0, 9, b"Grunt", b"GruntCoin", x"e2809cf09f9aa7f09f94a720496e74726f647563696e67204772756e74436f696e20e2809320746865206d656d6520636f696e2077697468206d6f726520706f7765722120496e7370697265642062792074686520636c617373696320486f6d6520496d70726f76656d656e742054562073686f772c207765e280997265206275696c64696e67206c61756768732c20636f6d6d756e6974792c20616e642063727970746f206761696e73206f6e6520746f6f6c20617420612074696d652e20f09f9ba0efb88ff09f92b020234772756e74436f696e20234d6f7265506f776572202343727970746f57697468546f6f6c73e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a17f5009dc6cee2d8707f85df902a482blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

