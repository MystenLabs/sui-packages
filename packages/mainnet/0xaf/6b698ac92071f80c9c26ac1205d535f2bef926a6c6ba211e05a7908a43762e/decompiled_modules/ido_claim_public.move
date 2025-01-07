module 0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::ido_claim_public {
    struct PoolClaim has store, key {
        id: 0x2::object::UID,
        turn: u64,
        timestamp_start: u64,
        total_supply: u64,
        total_claimed: u64,
        balance_claim: 0x2::balance::Balance<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>,
        percent: u64,
        total_percent: u64,
        key: vector<u8>,
    }

    struct InfoClaimRefund has copy, drop, store {
        total_public_deposit: u64,
        total_public_claim: u64,
        total_claimed: u64,
    }

    struct TocenIdoDataClaim has store, key {
        id: 0x2::object::UID,
        total_token_sale: u64,
        percent_rate_price_sale: u64,
        rate_price_sale: u64,
        total_claimed: u64,
        timestamp_start_not_sale: u64,
        not_sale: 0x2::balance::Balance<0x2::sui::SUI>,
        key_not_sale: vector<u8>,
    }

    struct EventClaim has copy, drop {
        object_turn: 0x2::object::ID,
        turn: u64,
        owner_claim: address,
        price_claim: u64,
    }

    struct EventRefund has copy, drop {
        owner_refund: address,
        price_refund: u64,
    }

    fun checkOwnerSignClaim(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg2)));
        let v1 = 0x1::string::utf8(arg0);
        0x1::string::sub_string(&v1, 0, 66) == v0 && 0x1::string::sub_string(&v1, 67, 0x1::string::length(&v1)) == 0x1::string::utf8(numberToStr(arg1))
    }

    public entry fun claim_coins_with_public(arg0: &0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::tocen_event_ido::TocenIdoData, arg1: &mut TocenIdoDataClaim, arg2: &mut PoolClaim, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg2.key, &arg5), 12);
        assert!(arg3 == arg2.turn, 7);
        let (v0, v1) = 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::tocen_event_ido::get_balance_public_deposit(arg0, arg7);
        assert!(v0 == 1, 10);
        assert!(!0x2::dynamic_field::exists_<address>(&arg2.id, 0x2::tx_context::sender(arg7)), 8);
        assert!(checkOwnerSignClaim(arg5, arg3, arg7), 13);
        assert!(arg2.timestamp_start <= 0x2::clock::timestamp_ms(arg6), 9);
        if (!0x2::dynamic_field::exists_<address>(&arg1.id, 0x2::tx_context::sender(arg7))) {
            let v2 = InfoClaimRefund{
                total_public_deposit : v1,
                total_public_claim   : v1 * arg1.percent_rate_price_sale / arg1.rate_price_sale,
                total_claimed        : 0,
            };
            0x2::dynamic_field::add<address, InfoClaimRefund>(&mut arg1.id, 0x2::tx_context::sender(arg7), v2);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<address, InfoClaimRefund>(&mut arg1.id, 0x2::tx_context::sender(arg7));
        let v4 = &mut v3.total_claimed;
        let v5 = v3.total_public_claim * arg2.percent / arg2.total_percent;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>>(0x2::coin::from_balance<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(0x2::balance::split<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(&mut arg2.balance_claim, v5), arg7), 0x2::tx_context::sender(arg7));
        *v4 = *v4 + v5;
        arg1.total_claimed = arg1.total_claimed + v5;
        0x2::dynamic_field::add<address, u64>(&mut arg2.id, 0x2::tx_context::sender(arg7), v5);
        let v6 = EventClaim{
            object_turn : 0x2::object::id<PoolClaim>(arg2),
            turn        : arg3,
            owner_claim : 0x2::tx_context::sender(arg7),
            price_claim : v5,
        };
        0x2::event::emit<EventClaim>(v6);
    }

    public entry fun create_pool_claim(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::witness::check_owner(arg5), 1);
        let v0 = PoolClaim{
            id              : 0x2::object::new(arg5),
            turn            : arg0,
            timestamp_start : arg1,
            total_supply    : arg2,
            total_claimed   : 0,
            balance_claim   : 0x2::balance::zero<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(),
            percent         : arg3,
            total_percent   : arg4,
            key             : 0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::utils::get_key_claim(),
        };
        0x2::transfer::share_object<PoolClaim>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        init_ido(arg0);
    }

    public fun init_ido(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TocenIdoDataClaim{
            id                       : 0x2::object::new(arg0),
            total_token_sale         : 0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::utils::get_total_token_sale(),
            percent_rate_price_sale  : 0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::utils::get_percent_rate_price_sale(),
            rate_price_sale          : 0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::utils::get_rate_price_sale(),
            total_claimed            : 0,
            timestamp_start_not_sale : 0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::utils::get_time_not_sale(),
            not_sale                 : 0x2::balance::zero<0x2::sui::SUI>(),
            key_not_sale             : 0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::utils::get_key_not_sale(),
        };
        0x2::transfer::share_object<TocenIdoDataClaim>(v0);
    }

    public fun numberToStr(arg0: u64) : vector<u8> {
        let v0 = b"";
        while (arg0 % 10 >= 0 && arg0 > 0) {
            let v1 = b"0123456789";
            0x1::vector::insert<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, arg0 % 10), 0);
            arg0 = arg0 / 10;
        };
        v0
    }

    public entry fun pool_claim_not_sale(arg0: &mut TocenIdoDataClaim, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::witness::check_owner(arg3), 1);
        let v0 = &mut arg0.not_sale;
        transferSui(v0, arg1, arg2, arg3);
    }

    public entry fun refund_coins_with_public(arg0: &0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::tocen_event_ido::TocenIdoData, arg1: &mut TocenIdoDataClaim, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1.key_not_sale, &arg3), 12);
        let (v0, v1) = 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::tocen_event_ido::get_balance_public_deposit(arg0, arg5);
        assert!(v0 == 1, 1);
        let v2 = EventRefund{
            owner_refund : 0x2::tx_context::sender(arg5),
            price_refund : v1,
        };
        0x2::event::emit<EventRefund>(v2);
    }

    public entry fun token_pool_claim(arg0: &mut PoolClaim, arg1: u64, arg2: 0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::witness::check_owner(arg4), 1);
        assert!(arg1 == arg0.turn, 7);
        let v0 = &mut arg0.balance_claim;
        transferToce(v0, arg2, arg3, arg4);
    }

    fun transferSui(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 6);
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    fun transferToce(arg0: &mut 0x2::balance::Balance<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>, arg1: 0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(&arg1) >= arg2, 6);
        0x2::balance::join<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(arg0, 0x2::balance::split<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(0x2::coin::balance_mut<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun up_pool_claim(arg0: &mut PoolClaim, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::witness::check_owner(arg6), 1);
        assert!(arg1 == arg0.turn, 7);
        arg0.timestamp_start = arg2;
        arg0.total_supply = arg3;
        arg0.percent = arg4;
        arg0.total_percent = arg5;
    }

    public entry fun upkey_pool_claim(arg0: &mut PoolClaim, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::witness::check_owner(arg3), 1);
        assert!(arg1 == arg0.turn, 7);
        arg0.key = arg2;
    }

    public entry fun withs(arg0: &mut TocenIdoDataClaim, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.not_sale, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun witht(arg0: &mut PoolClaim, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>>(0x2::coin::from_balance<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(0x2::balance::split<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(&mut arg0.balance_claim, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

