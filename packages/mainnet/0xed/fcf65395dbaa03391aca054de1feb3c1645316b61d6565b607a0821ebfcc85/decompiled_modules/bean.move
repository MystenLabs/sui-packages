module 0xedfcf65395dbaa03391aca054de1feb3c1645316b61d6565b607a0821ebfcc85::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 6, b"Bean", b"Crazy Beanz", x"57656c636f6d6520746f204372617a79204265616e7a20e28094206120776562332067616d696669656420657870657269656e6365206f6e20746865202453554920626c6f636b636861696e2e204865726520637265617469766974792c206368616f732c20616e6420636f6d6d756e697479207468726976652e204275696c6420796f7572204265616e2c206a6f696e20636f6d7065746974696f6e7320616e6420706c6179206c697665206d696e692d67616d65732e20436865636b206f757420372041204c656d6f6e20616e6420646973636f766572206974732068696464656e2067656d732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1756982147458.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

