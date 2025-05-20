module 0x1945b8fea7c1413575722f03490956160104a6ebba5aadf40d888b454ed11d61::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: 0x2::coin::Coin<MY_COIN>) {
        0x2::coin::burn<MY_COIN>(arg0, arg1);
        let v0 = BurnEvent{amount: 0x2::coin::value<MY_COIN>(&arg1)};
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 2, b"MY", b"My Coin", b"My coi description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

