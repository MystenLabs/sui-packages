module 0x1c951aa99ea3dd70fa2c89fb02ab109058d0a64db2fed4cea1a150cb10f99728::bpyc {
    struct BPYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPYC>(arg0, 6, b"BPYC", b"BoredPepe Yacht Club", x"244250594320746865206d6f7374206d656d6561626c65206d656d65636f696e20696e206578697374656e63652e20737570706f72746564206279205669727475616c2050726f746f636f6c2e2054686520646f6773206861766520686164207468656972206461792c206974e28099732074696d6520666f72205065706520746f2074616b6520726569676e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731006328385.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPYC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPYC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

