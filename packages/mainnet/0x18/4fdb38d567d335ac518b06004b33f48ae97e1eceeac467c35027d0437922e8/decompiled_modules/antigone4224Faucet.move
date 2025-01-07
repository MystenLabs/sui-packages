module 0x184fdb38d567d335ac518b06004b33f48ae97e1eceeac467c35027d0437922e8::antigone4224Faucet {
    struct ANTIGONE4224FAUCET has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANTIGONE4224FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ANTIGONE4224FAUCET>>(0x2::coin::mint<ANTIGONE4224FAUCET>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: ANTIGONE4224FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTIGONE4224FAUCET>(arg0, 6, b"ANTIGONE4224FAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTIGONE4224FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTIGONE4224FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

