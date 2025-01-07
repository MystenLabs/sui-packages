module 0x2a423fcd12cee42b9e3c9e77c4b9267567329573e2a118decfb61556511cc7c5::firma_faucet {
    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct FIRMA_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FIRMA_FAUCET>, arg1: 0x2::coin::Coin<FIRMA_FAUCET>) {
        0x2::coin::burn<FIRMA_FAUCET>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FIRMA_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FIRMA_FAUCET>>(0x2::coin::mint<FIRMA_FAUCET>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: FIRMA_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRMA_FAUCET>(arg0, 10, b"FIRMA Faucet", b"FIRMA Faucet Coins", b"Get some free coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRMA_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FIRMA_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

