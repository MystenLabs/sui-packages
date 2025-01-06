module 0xc0b29002051c50cf251b05e77186efb5b640793db5ccebc7515c4da1cd069800::dbtai {
    struct DBTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBTAI>(arg0, 6, b"DBTAI", b"Digital BrainTech AI", x"4469676974616c20427261696e2054656368204149204167656e742073696d706c69666965732063727970746f206173736574206d616e6167656d656e74206279206f7074696d697a696e67207472616e73616374696f6e732c20706f7274666f6c696f20747261636b696e672c20616e642044654669206f70706f7274756e6974696573206163726f737320537569206e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736161715688_6ff3a1d7ed.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

