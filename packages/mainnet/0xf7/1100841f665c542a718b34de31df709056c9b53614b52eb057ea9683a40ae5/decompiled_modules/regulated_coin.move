module 0xf71100841f665c542a718b34de31df709056c9b53614b52eb057ea9683a40ae5::regulated_coin {
    struct REGULATED_COIN has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REGULATED_COIN>, arg1: 0x2::coin::Coin<REGULATED_COIN>) {
        0x2::coin::burn<REGULATED_COIN>(arg0, arg1);
        let v0 = BurnEvent{amount: 0x2::coin::value<REGULATED_COIN>(&arg1)};
        0x2::event::emit<BurnEvent>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<REGULATED_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<REGULATED_COIN>>(0x2::coin::mint<REGULATED_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<REGULATED_COIN>(arg0, 5, b"tst", b"TST", b"description", 0x1::option::none<0x2::url::Url>(), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGULATED_COIN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGULATED_COIN>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

