module 0x124b33e794586d06157a86e019f635338fc50978a3c22c61c6fb9c7e3f3a40d7::DREAMLCH {
    struct DREAMLCH has drop {
        dummy_field: bool,
    }

    struct MintCapability has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<DREAMLCH>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DREAMLCH>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DREAMLCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREAMLCH>(arg0, 9, b"UNIT DREAM LAUNCH", b"DREAMLCH", x"554e495420445245414d204c41554e4348202d204261636b2069646561732e204275696c6420647265616d73207769746820556e6974204e6574776f726b2e20445245414d2066756e64732063726561746976652076656e747572657320e2809420656d706f776572696e6720636f6d6d756e697469657320746f20737570706f72742c20766f74652c20616e6420736861726520696e207468652073756363657373206f6620626f6c642069646561732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unitecosystem/UnitDreamLaunch/main/DreamLaunch512.png")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 287500000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DREAMLCH>>(v1);
        0x2::transfer::public_freeze_object<MintCapability>(v2);
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DREAMLCH> {
        assert!(arg1 > 0, 0);
        assert!(arg0.total_minted + arg1 <= 287500000000000, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<DREAMLCH>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

