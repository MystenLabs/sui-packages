module 0xc4b7578c0bc2f839095e4eccf1ab9af212f5d26dca022b20e4c65c3747fbe4ad::SYDNEYLCH {
    struct SYDNEYLCH has drop {
        dummy_field: bool,
    }

    struct MintCapability has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<SYDNEYLCH>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SYDNEYLCH>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SYDNEYLCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYDNEYLCH>(arg0, 9, b"UNIT SYDNEY LAUNCH", b"SYDNEYLCH", x"554e4954205359444e4559204c41554e4348202d20204120576562332d706f776572656420636f6d6d756e69747920746f6b656e20636170747572696e67205379646e6579e2809973207370697269742c20696e6e6f766174696f6e2c20616e64206c6966657374796c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unitecosystem/Unit-Ecosystem/main/SYDNEY/sydney512.png")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 287500000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYDNEYLCH>>(v1);
        0x2::transfer::public_freeze_object<MintCapability>(v2);
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SYDNEYLCH> {
        assert!(arg1 > 0, 0);
        assert!(arg0.total_minted + arg1 <= 287500000000000, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<SYDNEYLCH>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

