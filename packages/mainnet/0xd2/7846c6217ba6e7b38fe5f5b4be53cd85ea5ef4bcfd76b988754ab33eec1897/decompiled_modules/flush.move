module 0xd27846c6217ba6e7b38fe5f5b4be53cd85ea5ef4bcfd76b988754ab33eec1897::flush {
    struct FLUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUSH>(arg0, 6, b"Flush", b"$flush on Sui", x"466c757368436f696e2069732074686520756c74696d617465206d656d65636f696e206d616b696e672077617665732028616e642073706c61736865732920696e207468652063727970746f20776f726c642e2057697468206974732069636f6e696320746f696c6574206d6173636f742c206974e2809973206865726520746f20666c75736820626f72696e6720636f696e7320646f776e2074686520647261696e20616e642070756d7020796f757220706f7274666f6c696f2066756c6c206f662066756e2e0a2a576865726520657665727920666c7573682066696c6c7320796f75722077616c6c65742120f09f9abdf09f92b82a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734097662131.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUSH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

