module 0x1c10afc3b04300af998bc7aa085be018a0eff64b824e2975f9a55001b18ffd41::boysclub {
    struct BOYSCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSCLUB>(arg0, 9, b"BOYSCLUB", b"Boys Club On Sui", x"4f6e207468652053756920636861696e2c2074686520426f797320436c756220746f6b656e20656d65726765642061732061207472696275746520746f204d617474204675726965e28099732069636f6e696320426f797320436c756220636f6d69632e20437261667465642062792066616e732c206974732075706f6e207468652068756d6f7220616e642063616d6172616465726965206f6620506570652c20416e64792c20576f6c662c20616e642042726574742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=138,fit=crop,q=95/mxBZ1WV4vvU8Olpk/group-5-copy-Yyv3QJ82QqCG6lOX.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOYSCLUB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOYSCLUB>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSCLUB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

