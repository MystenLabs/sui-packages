module 0xa3f7df46e8c6145821d09c076f47c0ee27dba01f88856bdcb5d973c1da98a896::BOSTONLCH {
    struct BOSTONLCH has drop {
        dummy_field: bool,
    }

    struct MintCapability has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<BOSTONLCH>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOSTONLCH>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BOSTONLCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSTONLCH>(arg0, 9, b"UNIT BOSTON LAUNCH", b"BOSTONLCH", b"UNIT BOSTON LAUNCH -  Community supporting Boston, Tokenized. The Decentralized City Token by Unit Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unitecosystem/Unit-Ecosystem/main/BOSTON/boston512.png")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 287500000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSTONLCH>>(v1);
        0x2::transfer::public_freeze_object<MintCapability>(v2);
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BOSTONLCH> {
        assert!(arg1 > 0, 0);
        assert!(arg0.total_minted + arg1 <= 287500000000000, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<BOSTONLCH>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

