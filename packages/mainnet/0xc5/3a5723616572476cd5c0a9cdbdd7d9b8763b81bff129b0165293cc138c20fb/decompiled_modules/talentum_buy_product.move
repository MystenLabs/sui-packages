module 0xc53a5723616572476cd5c0a9cdbdd7d9b8763b81bff129b0165293cc138c20fb::talentum_buy_product {
    struct TalentumBuyProductEvent has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
        product_id: u64,
        user_id: u64,
    }

    public entry fun buy_product(arg0: u64, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1);
        let v1 = TalentumBuyProductEvent{
            sender     : 0x2::tx_context::sender(arg4),
            receiver   : arg1,
            amount     : v0,
            product_id : arg0,
            user_id    : arg2,
        };
        0x2::event::emit<TalentumBuyProductEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

