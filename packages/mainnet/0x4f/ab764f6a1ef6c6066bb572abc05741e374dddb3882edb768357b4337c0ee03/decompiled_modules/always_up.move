module 0x4fab764f6a1ef6c6066bb572abc05741e374dddb3882edb768357b4337c0ee03::always_up {
    struct ALWAYS_UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALWAYS_UP, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 616 || 0x2::tx_context::epoch(arg1) == 617, 1);
        let (v0, v1) = 0x2::coin::create_currency<ALWAYS_UP>(arg0, 9, b"UP", b"Always UP", x"42792073696d706c7920686f6c64696e6720416c7761797320555020746f6b656e732c20796f7520706172746963697061746520696e20612073797374656d20776865726520736361726369747920616e64207265776172647320776f726b20746f67657468657220746f20696e6372656173652076616c7565206f7665722074696d652e20546f6765746865722c206c6574e280997320484f444c20666f72207468652066757475726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreifgn5jwuir27jj6rtexpnhun6sqdeqo3ua3yu5wuae7nx5ireptku.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALWAYS_UP>(&mut v2, 1000000000000000000, @0x1e8ba64e6409c79ab88d42de417ec6fa2e53d2902c1ce71d36f9134006c0a5f4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALWAYS_UP>>(v2, @0x1e8ba64e6409c79ab88d42de417ec6fa2e53d2902c1ce71d36f9134006c0a5f4);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALWAYS_UP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<ALWAYS_UP>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALWAYS_UP>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<ALWAYS_UP>, arg1: &mut 0x2::coin::CoinMetadata<ALWAYS_UP>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<ALWAYS_UP>(arg0, arg1, arg2);
        0x2::coin::update_symbol<ALWAYS_UP>(arg0, arg1, arg3);
        0x2::coin::update_description<ALWAYS_UP>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<ALWAYS_UP>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

