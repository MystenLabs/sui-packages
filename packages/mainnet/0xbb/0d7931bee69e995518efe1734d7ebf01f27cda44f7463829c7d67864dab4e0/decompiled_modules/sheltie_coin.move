module 0xbb0d7931bee69e995518efe1734d7ebf01f27cda44f7463829c7d67864dab4e0::sheltie_coin {
    struct SHELTIE_COIN has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHELTIE_COIN>, arg1: u64, arg2: 0x2::coin::Coin<SHELTIE_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SHELTIE_COIN>(arg0, arg2);
        let v0 = BurnEvent{amount: arg1};
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHELTIE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHELTIE_COIN>>(0x2::coin::mint<SHELTIE_COIN>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: SHELTIE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHELTIE_COIN>(arg0, 6, b"SHELTIE_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHELTIE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHELTIE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

