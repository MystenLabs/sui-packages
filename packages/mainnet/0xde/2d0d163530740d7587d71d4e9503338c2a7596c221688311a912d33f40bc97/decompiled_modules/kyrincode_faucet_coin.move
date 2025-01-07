module 0xde2d0d163530740d7587d71d4e9503338c2a7596c221688311a912d33f40bc97::kyrincode_faucet_coin {
    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct KYRINCODE_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KYRINCODE_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KYRINCODE_FAUCET_COIN>>(0x2::coin::mint<KYRINCODE_FAUCET_COIN>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: KYRINCODE_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYRINCODE_FAUCET_COIN>(arg0, 6, b"KYFC", b"KyrinCode Faucet Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYRINCODE_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<KYRINCODE_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

