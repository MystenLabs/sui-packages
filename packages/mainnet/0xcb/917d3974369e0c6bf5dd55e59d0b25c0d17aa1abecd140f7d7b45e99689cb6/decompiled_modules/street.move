module 0xcb917d3974369e0c6bf5dd55e59d0b25c0d17aa1abecd140f7d7b45e99689cb6::street {
    struct STREET has drop {
        dummy_field: bool,
    }

    fun init(arg0: STREET, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 603 || 0x2::tx_context::epoch(arg1) == 604, 1);
        let (v0, v1) = 0x2::coin::create_currency<STREET>(arg0, 0, b"STC", b"street", x"53747265657420436f696e20697320616e20696e6e6f7661746976652063727970746f63757272656e63792064657369676e656420746f206d6572676520746865206469676974616c20616e6420706879736963616c20776f726c64732c206372656174696e6720616e20656e676167696e6720616e6420696e74657261637469766520657870657269656e636520666f722075736572732e20576974682053747265657420436f696e2c20796f752063616e206578706c6f726520796f757220737572726f756e64696e67732c20646973636f76657220636f696e7320736361747465726564206163726f73732074686520737472656574732c20616e642072656465656d207468656d20666f72207265616c2076616c7565e28094616c6c207768696c6520686176696e672066756e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreifh7lazljnb5vwjqevtpgl4kf65lds46tqs2yiz5km6zuaeeql6qu.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STREET>(&mut v2, 1000000000, @0xab37f0f8f05a0127f8dfde164a86ea13a4189258b40b97902fceab32aa5877ba, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STREET>>(v2, @0xab37f0f8f05a0127f8dfde164a86ea13a4189258b40b97902fceab32aa5877ba);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STREET>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<STREET>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STREET>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<STREET>, arg1: &mut 0x2::coin::CoinMetadata<STREET>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<STREET>(arg0, arg1, arg2);
        0x2::coin::update_symbol<STREET>(arg0, arg1, arg3);
        0x2::coin::update_description<STREET>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<STREET>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

