module 0xb4ab75fbb00e23332c25abbaf8dab99c8fbf79d01ad477952c5373078c44a206::reflection {
    struct REFLECTION has drop {
        dummy_field: bool,
    }

    struct TokenPolicy has key {
        id: 0x2::object::UID,
        fee_percentage: u64,
        fee_collector: address,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        fee_amount: u64,
        from: address,
        to: address,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REFLECTION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::mint<REFLECTION>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: REFLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFLECTION>(arg0, 9, b"RFLX", b"Reflection Token", b"Reflection token with 5% fee", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TokenPolicy{
            id             : 0x2::object::new(arg1),
            fee_percentage : 5,
            fee_collector  : @0x84631ff961b7bdc7193deed7393d8f7c74f7c6ec34b86e3f09f63aa3dc196c7f,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFLECTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REFLECTION>>(v1);
        0x2::transfer::share_object<TokenPolicy>(v2);
    }

    public entry fun transfer_hook(arg0: &TokenPolicy, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollected{
            amount     : arg1,
            fee_amount : arg1 * arg0.fee_percentage / 100,
            from       : arg2,
            to         : arg3,
        };
        0x2::event::emit<FeeCollected>(v0);
    }

    // decompiled from Move bytecode v6
}

