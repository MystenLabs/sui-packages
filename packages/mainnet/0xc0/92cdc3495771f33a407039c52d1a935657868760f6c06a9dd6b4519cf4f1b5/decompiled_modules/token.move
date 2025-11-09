module 0xc092cdc3495771f33a407039c52d1a935657868760f6c06a9dd6b4519cf4f1b5::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct BurnedWicp has copy, drop, store {
        icp_principal: vector<u8>,
        amount: u64,
        nonce: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnedWicp{
            icp_principal : arg2,
            amount        : 0x2::coin::burn<TOKEN>(arg0, arg1),
            nonce         : arg3,
        };
        0x2::event::emit<BurnedWicp>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 8, b"wICP", b"Wrapped ICP", b"ICP bridged to Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

