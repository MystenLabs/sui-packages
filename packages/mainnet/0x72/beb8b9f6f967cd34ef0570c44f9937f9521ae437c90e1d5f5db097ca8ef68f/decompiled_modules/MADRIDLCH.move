module 0x72beb8b9f6f967cd34ef0570c44f9937f9521ae437c90e1d5f5db097ca8ef68f::MADRIDLCH {
    struct MADRIDLCH has drop {
        dummy_field: bool,
    }

    struct MintCapability has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<MADRIDLCH>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MADRIDLCH>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MADRIDLCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADRIDLCH>(arg0, 9, b"UNIT MADRID LAUNCH", b"MADRIDLCH", x"554e4954204d4144524944204c41554e4348202d204120646563656e7472616c697a6564206369747920746f6b656e206275696c742062792074686520636f6d6d756e6974792c2063656c6562726174696e67204d6164726964e280997320656e657267792c20637265617469766974792c20616e6420676c6f62616c207370697269742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unitecosystem/unitecosytem/main/madrid.png")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 287500000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MADRIDLCH>>(v1);
        0x2::transfer::public_freeze_object<MintCapability>(v2);
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MADRIDLCH> {
        assert!(arg1 > 0, 0);
        assert!(arg0.total_minted + arg1 <= 287500000000000, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<MADRIDLCH>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

