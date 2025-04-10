module 0x8719183171a8a86fd9ce82b578810593d24df5f5aeb835da6ee3c232500b1391::skitest {
    struct SKITEST has drop {
        dummy_field: bool,
    }

    struct MintCapability has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<SKITEST>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SKITEST>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SKITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITEST>(arg0, 9, b"SKITEST", b"SKITEST", b"Meet SKITEST the cutest jellyfish meme coin floating through the blockchain ocean! Dive into a world of fun, community, and rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unitecosystem/UnitSkiLaunch/refs/heads/main/Ski.png")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 285000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKITEST>>(v1);
        0x2::transfer::public_freeze_object<MintCapability>(v2);
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SKITEST> {
        assert!(arg1 > 0, 0);
        assert!(arg0.total_minted + arg1 <= 285000, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<SKITEST>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

