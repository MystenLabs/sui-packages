module 0x838cf1e3d440ce4fbb411feda409a4d7e23c869ae2a5e5a440b4c82fe5fdcfff::devine {
    struct DEVINE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEVINE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEVINE>>(0x2::coin::mint<DEVINE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: DEVINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVINE>(arg0, 9, b"DEVI", b"Devine", x"24444556492069732074686520446576696e652050726f746f636f6ce280997320636f7265207574696c69747920746f6b656e2c20656d706f776572696e6720686f6c6465727320746f207374616b6520666f7220657874726120726577617264732c20736861726520696e2070726f746f636f6c20666565732c20616e6420637265617465206e6577206d61726b6574732077697468696e207468652065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://presale.devineprotocol.com/devi-icon.svg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEVINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

