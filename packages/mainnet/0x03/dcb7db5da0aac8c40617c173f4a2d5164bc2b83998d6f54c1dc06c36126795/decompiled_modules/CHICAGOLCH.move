module 0x3dcb7db5da0aac8c40617c173f4a2d5164bc2b83998d6f54c1dc06c36126795::CHICAGOLCH {
    struct CHICAGOLCH has drop {
        dummy_field: bool,
    }

    struct MintCapability has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<CHICAGOLCH>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHICAGOLCH>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHICAGOLCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICAGOLCH>(arg0, 9, b"UNIT CHICAGO LAUNCH", b"CHICAGOLCH", x"554e4954204348494341474f204c41554e4348202d204120646563656e7472616c697a656420706c6174666f726d20636f6e6e656374696e67204368696361676fe2809973206275696c646572732c2063726561746f72732c20616e6420636f6d6d756e6974696573206163726f7373205765623320616e64206265796f6e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unitecosystem/Unit-Ecosystem/main/CHICAGO/chicago512.png")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 287500000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICAGOLCH>>(v1);
        0x2::transfer::public_freeze_object<MintCapability>(v2);
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CHICAGOLCH> {
        assert!(arg1 > 0, 0);
        assert!(arg0.total_minted + arg1 <= 287500000000000, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<CHICAGOLCH>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

