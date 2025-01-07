module 0x6106c04a586f0f003fcdf7fb33564f373680ddcc1beb716fd22e2952e227eb3::tubbi {
    struct TUBBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUBBI, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 625 || 0x2::tx_context::epoch(arg1) == 626, 1);
        let (v0, v1) = 0x2::coin::create_currency<TUBBI>(arg0, 9, b"TUBBI", b"TUBBI", x"54554242492069732061207265766f6c7574696f6e617279206d656d652d706f776572656420746f6b656e2064657369676e656420746f20756e697465207468652067616d696e6720616e642063727970746f20636f6d6d756e697469657320696e20612066756e20616e6420656e676167696e67207761792e200a41732074686520666972737420706c617961626c652063686172616374657220696e204d656d654172656e612c20545542424920656d706f7765727320757365727320746f20706172746963697061746520696e20746872696c6c696e6720626174746c65732c207374616b6520726577617264732c20616e6420696e666c75656e63652067616d65706c61792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreieayo7pa5kha2xbac2anuk6mym7ardvxhwefoa7hlazdannvlql54.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUBBI>(&mut v2, 10000000000000000000, @0x274cfadc84d67752c0e074caa6a29361a8f56cd950cd82d4bf55ce8ea0cbcf95, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUBBI>>(v2, @0x274cfadc84d67752c0e074caa6a29361a8f56cd950cd82d4bf55ce8ea0cbcf95);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUBBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

