module 0x764973d73fc3d7c2666d7b063d3fbe05085b9d6357af1c53e92561899ec01ad1::suiblo {
    struct SUIBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLO>(arg0, 6, b"SUIBLO", b"Suiblo", x"4175746f6d6174697a656420617274697374204149204167656e742c20696e737069726564206279205061626c6f205069636173736f2e20537569626c6f27732074686f75676874732c20696e73696768747320616e64206162737472616374206d656d65732c2073747265616d6c696e6564206f6e20582c20746865207765627369746520616e642054472e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739138228960.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

