module 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events {
    struct ArtworkCreated has copy, drop {
        artwork_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        appraised_value: u64,
        supply: u64,
    }

    struct PresaleStarted has copy, drop {
        artwork_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        price: u64,
    }

    struct TradingStarted has copy, drop {
        artwork_id: 0x2::object::ID,
        start_time: u64,
    }

    struct RedeemStarted has copy, drop {
        artwork_id: 0x2::object::ID,
        start_time: u64,
        final_sale_price: u64,
        usdc_per_token: u64,
    }

    struct TokensPurchased has copy, drop {
        artwork_id: 0x2::object::ID,
        offering_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        usdc_amount: u64,
        fee_amount: u64,
    }

    struct TokensUnlocked has copy, drop {
        artwork_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct ArtworkSold has copy, drop {
        artwork_id: 0x2::object::ID,
        sale_price: u64,
    }

    struct TokensRedeemed has copy, drop {
        artwork_id: 0x2::object::ID,
        redeemer: address,
        amount: u64,
        usdc_amount: u64,
    }

    struct TokenStored<phantom T0> has copy, drop {
        max_supply: u64,
        from: address,
    }

    public fun emit_artwork_created(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64) {
        let v0 = ArtworkCreated{
            artwork_id      : arg0,
            name            : arg1,
            description     : arg2,
            image_url       : arg3,
            appraised_value : arg4,
            supply          : arg5,
        };
        0x2::event::emit<ArtworkCreated>(v0);
    }

    public fun emit_artwork_sold(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ArtworkSold{
            artwork_id : arg0,
            sale_price : arg1,
        };
        0x2::event::emit<ArtworkSold>(v0);
    }

    public fun emit_presale_started(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = PresaleStarted{
            artwork_id : arg0,
            start_time : arg1,
            end_time   : arg2,
            price      : arg3,
        };
        0x2::event::emit<PresaleStarted>(v0);
    }

    public fun emit_redeem_started(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = RedeemStarted{
            artwork_id       : arg0,
            start_time       : arg1,
            final_sale_price : arg2,
            usdc_per_token   : arg3,
        };
        0x2::event::emit<RedeemStarted>(v0);
    }

    public fun emit_token_stored<T0>(arg0: u64, arg1: address) {
        let v0 = TokenStored<T0>{
            max_supply : arg0,
            from       : arg1,
        };
        0x2::event::emit<TokenStored<T0>>(v0);
    }

    public fun emit_tokens_purchased(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = TokensPurchased{
            artwork_id  : arg0,
            offering_id : arg1,
            buyer       : arg2,
            amount      : arg3,
            usdc_amount : arg4,
            fee_amount  : arg5,
        };
        0x2::event::emit<TokensPurchased>(v0);
    }

    public fun emit_tokens_redeemed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = TokensRedeemed{
            artwork_id  : arg0,
            redeemer    : arg1,
            amount      : arg2,
            usdc_amount : arg3,
        };
        0x2::event::emit<TokensRedeemed>(v0);
    }

    public fun emit_tokens_unlocked(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = TokensUnlocked{
            artwork_id : arg0,
            owner      : arg1,
            amount     : arg2,
        };
        0x2::event::emit<TokensUnlocked>(v0);
    }

    public fun emit_trading_started(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = TradingStarted{
            artwork_id : arg0,
            start_time : arg1,
        };
        0x2::event::emit<TradingStarted>(v0);
    }

    // decompiled from Move bytecode v6
}

