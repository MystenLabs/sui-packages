module 0x3a570f21eaa109b1a16fcb7534f8698bad7a672c69ca5c16226924eb0e1d3a66::JAKARTALCH {
    struct JAKARTALCH has drop {
        dummy_field: bool,
    }

    struct MintCapability has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<JAKARTALCH>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JAKARTALCH>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JAKARTALCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAKARTALCH>(arg0, 9, b"UNIT JAKARTA LAUNCH", b"JAKARTALCH", x"554e4954204a414b41525441204c41554e4348202d20204120636f6d6d756e6974792d6f776e656420746f6b656e20636170747572696e67204a616b61727461e280997320656e657267792c2067726f7774682c20616e6420637265617469766520706f74656e7469616c20696e20576562332e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unitecosystem/Unit-Ecosystem/main/JAKARTA/jkt512.png")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 287500000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAKARTALCH>>(v1);
        0x2::transfer::public_freeze_object<MintCapability>(v2);
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JAKARTALCH> {
        assert!(arg1 > 0, 0);
        assert!(arg0.total_minted + arg1 <= 287500000000000, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<JAKARTALCH>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

