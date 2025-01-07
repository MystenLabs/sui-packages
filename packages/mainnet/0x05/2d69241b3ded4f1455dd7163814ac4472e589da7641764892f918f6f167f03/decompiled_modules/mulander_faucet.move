module 0x52d69241b3ded4f1455dd7163814ac4472e589da7641764892f918f6f167f03::mulander_faucet {
    struct MULANDER_FAUCET has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MULANDER_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MULANDER_FAUCET>>(0x2::coin::mint<MULANDER_FAUCET>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: MULANDER_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULANDER_FAUCET>(arg0, 6, b"LANF", b"Mulander faucet coin", b"Faucet in sui move", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MULANDER_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULANDER_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

