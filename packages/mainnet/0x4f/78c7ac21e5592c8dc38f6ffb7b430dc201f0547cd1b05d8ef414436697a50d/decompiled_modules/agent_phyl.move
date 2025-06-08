module 0x4f78c7ac21e5592c8dc38f6ffb7b430dc201f0547cd1b05d8ef414436697a50d::agent_phyl {
    struct AGENT_PHYL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT_PHYL, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 787 || 0x2::tx_context::epoch(arg1) == 788, 1);
        let (v0, v1) = 0x2::coin::create_currency<AGENT_PHYL>(arg0, 9, b"PHYL", b"Agent PHYL", x"4167656e74205048594c205355492773204d656d652041490a0a4f6e2d636861696e20414920626f74616e697374207c204d656d6520776869737065726572207c204275696c74206f6e205375694e6574776f726b0a4465636f64696e6720576562332c2067726f77696e6720677265656e2074656368202620706f7374696e672064616e6b204149206d656d6573200a56657269666961626c652e2041646170746976652e2046756c6c7920646563656e7472616c697a65642e0a0a4a6f696e20746865206d6f76656d656e743a0a58202020203a2068747470733a2f2f782e636f6d2f6167656e747068796c6f6e7375690a5447203a2068747470733a2f2f742e6d652f6167656e747068796c6f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmdJbx9ydmF7wN8nzsSPB3ePumHVVbw8d3ouML9retp6aZ"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AGENT_PHYL>(&mut v2, 10000000000000000000, @0xc35f8efe2c835c96a6b49666bf6edd2ee5691d0426d1b42a0e22120b5c76b846, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT_PHYL>>(v2, @0xc35f8efe2c835c96a6b49666bf6edd2ee5691d0426d1b42a0e22120b5c76b846);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT_PHYL>>(v1);
    }

    // decompiled from Move bytecode v6
}

