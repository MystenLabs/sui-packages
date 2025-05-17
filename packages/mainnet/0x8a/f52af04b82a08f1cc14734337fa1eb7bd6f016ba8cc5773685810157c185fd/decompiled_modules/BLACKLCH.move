module 0x8af52af04b82a08f1cc14734337fa1eb7bd6f016ba8cc5773685810157c185fd::BLACKLCH {
    struct BLACKLCH has drop {
        dummy_field: bool,
    }

    struct MintCapability has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<BLACKLCH>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLACKLCH>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BLACKLCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKLCH>(arg0, 9, b"UNIT BLACK LAUNCH", b"BLACKLCH", x"554e495420424c41434b204c41554e4348202d20746865206469676974616c20746f6b656e206f6620426c61636b20657863656c6c656e636520e2809420737570706f7274696e6720656e7472657072656e657572732c20617274697374732c20616e6420636f6d6d756e6974696573206163726f7373204166726963612c2074686520416d6572696361732c207468652043617269626265616e2c20616e642074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unitecosystem/Unit-Ecosystem/main/BLACK/blacklaunch512.png")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 287500000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACKLCH>>(v1);
        0x2::transfer::public_freeze_object<MintCapability>(v2);
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BLACKLCH> {
        assert!(arg1 > 0, 0);
        assert!(arg0.total_minted + arg1 <= 287500000000000, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<BLACKLCH>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

