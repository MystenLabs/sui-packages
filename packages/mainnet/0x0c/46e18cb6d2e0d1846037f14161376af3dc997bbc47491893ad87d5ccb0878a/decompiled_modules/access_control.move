module 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::access_control {
    struct ReadTokenGenerated has copy, drop {
        token_id: 0x2::object::ID,
        article_id: 0x2::object::ID,
        reader: address,
        revenues: u64,
        fee: u64,
    }

    struct ReadTokenTransferred has copy, drop {
        token_id: 0x2::object::ID,
        recipient: address,
    }

    struct ReadTokenReceived has copy, drop {
        token_id: 0x2::object::ID,
        parent_id: 0x2::object::ID,
    }

    struct ReadToken has key {
        id: 0x2::object::UID,
        article_id: 0x2::object::ID,
        reader: address,
        created_at: u64,
    }

    public fun id(arg0: &ReadToken) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun transfer(arg0: ReadToken, arg1: address) {
        let v0 = ReadTokenTransferred{
            token_id  : 0x2::object::id<ReadToken>(&arg0),
            recipient : arg1,
        };
        0x2::event::emit<ReadTokenTransferred>(v0);
        0x2::transfer::transfer<ReadToken>(arg0, arg1);
    }

    public fun receive(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<ReadToken>) : ReadToken {
        let v0 = 0x2::transfer::receive<ReadToken>(arg0, arg1);
        let v1 = ReadTokenReceived{
            token_id  : 0x2::object::id<ReadToken>(&v0),
            parent_id : 0x2::object::uid_to_inner(arg0),
        };
        0x2::event::emit<ReadTokenReceived>(v1);
        v0
    }

    public fun article_id(arg0: &ReadToken) : 0x2::object::ID {
        arg0.article_id
    }

    public fun created_at(arg0: &ReadToken) : u64 {
        arg0.created_at
    }

    public fun generate_read_token(arg0: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::Article, arg1: &mut 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &mut 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::treasury::Treasury, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : ReadToken {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::id(arg0);
        assert!(0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::publication_id(arg0) == 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::id(arg1), 2);
        if (!0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::paid(arg0)) {
            abort 3
        };
        let v2 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::price(arg0);
        assert!(0x1::option::is_some<u64>(&v2), 4);
        let v3 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::price(arg0);
        let v4 = *0x1::option::borrow<u64>(&v3);
        let v5 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v5 == v4, 1);
        let (v6, v7) = if (v4 > 0) {
            0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::treasury::collect_pay_per_article_fee(arg2, &mut arg3, v1, v0, arg5);
            let v8 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
            0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::increase_revenues(arg1, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3), arg5);
            (v8, v5 - v8)
        } else {
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
            (0, 0)
        };
        let v9 = ReadToken{
            id         : 0x2::object::new(arg5),
            article_id : v1,
            reader     : v0,
            created_at : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        let v10 = ReadTokenGenerated{
            token_id   : 0x2::object::id<ReadToken>(&v9),
            article_id : v1,
            reader     : v0,
            revenues   : v6,
            fee        : v7,
        };
        0x2::event::emit<ReadTokenGenerated>(v10);
        v9
    }

    public fun reader(arg0: &ReadToken) : address {
        arg0.reader
    }

    public fun verify_read_token(arg0: &ReadToken, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::Article) : bool {
        if (arg0.article_id != 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::id(arg1) && !0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::has_article_friend(arg1, arg0.article_id)) {
            return false
        };
        true
    }

    public fun verify_subscription_access(arg0: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::subscription::SubscriptionNFT, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::Article, arg2: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg3: &0x2::clock::Clock) : bool {
        if (0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::id(arg2) != 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::publication_id(arg1)) {
            return false
        };
        if (0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::subscription::publication_id(arg0) != 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article::publication_id(arg1) && !0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::has_publication_friend(arg2, 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::subscription::publication_id(arg0))) {
            return false
        };
        if (!0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::subscription::is_valid(arg0, arg3)) {
            return false
        };
        0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::subscription::has_paid_access(arg0, arg3)
    }

    // decompiled from Move bytecode v7
}

