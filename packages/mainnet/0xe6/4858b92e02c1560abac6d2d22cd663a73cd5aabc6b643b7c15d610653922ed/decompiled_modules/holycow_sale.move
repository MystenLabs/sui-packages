module 0xe64858b92e02c1560abac6d2d22cd663a73cd5aabc6b643b7c15d610653922ed::holycow_sale {
    struct TokenSale<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        sale_token_type: 0x1::type_name::TypeName,
        payment_token_type: 0x1::type_name::TypeName,
        token_price: u64,
        max_supply: u64,
        sale_token_decimals: u8,
        total_sold: u64,
        status: u8,
        commission_rates: vector<u16>,
        token_balance: 0x2::balance::Balance<T0>,
        payment_balance: 0x2::balance::Balance<T1>,
        created_at: u64,
    }

    struct UserProfile has store {
        user: address,
        direct_referrer: 0x1::option::Option<address>,
        total_purchased: u64,
        total_referral_earnings: u64,
        pending_rewards: u64,
        level_counts: vector<u32>,
        registered_at: u64,
    }

    struct DSA has drop, store {
        id: 0x1::string::String,
        agent_address: address,
        percentage_share: u16,
        is_active: bool,
        total_earnings: u64,
        pending_rewards: u64,
        created_at: u64,
    }

    struct SaleRegistry has key {
        id: 0x2::object::UID,
        sales: 0x2::table::Table<0x2::object::ID, bool>,
        total_sales: u64,
    }

    struct UserTableKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DSATableKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SaleCreated<phantom T0, phantom T1> has copy, drop {
        sale_id: 0x2::object::ID,
        creator: address,
        sale_token_type: 0x1::string::String,
        payment_token_type: 0x1::string::String,
        token_price: u64,
        max_supply: u64,
        commission_rates: vector<u16>,
        timestamp: u64,
    }

    struct UserRegistered has copy, drop {
        sale_id: 0x2::object::ID,
        user: address,
        referrer: 0x1::option::Option<address>,
        timestamp: u64,
    }

    struct TokensPurchased<phantom T0, phantom T1> has copy, drop {
        sale_id: 0x2::object::ID,
        buyer: address,
        token_amount: u64,
        payment_amount: u64,
        timestamp: u64,
    }

    struct CommissionDistributed has copy, drop {
        sale_id: 0x2::object::ID,
        from_purchase: address,
        referrer: address,
        level: u8,
        commission_amount: u64,
        timestamp: u64,
    }

    struct RewardsClaimed<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct SaleStatusChanged has copy, drop {
        sale_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
        changer: address,
        timestamp: u64,
    }

    struct PriceUpdated has copy, drop {
        sale_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        updater: address,
        timestamp: u64,
    }

    struct CommissionRatesUpdated has copy, drop {
        sale_id: 0x2::object::ID,
        old_rates: vector<u16>,
        new_rates: vector<u16>,
        updater: address,
        timestamp: u64,
    }

    struct TokensAdded<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        amount_added: u64,
        new_token_balance: u64,
        timestamp: u64,
    }

    struct ProceedsWithdrawn<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        amount_withdrawn: u64,
        remaining_balance: u64,
        timestamp: u64,
    }

    struct TokensWithdrawn<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        amount_withdrawn: u64,
        remaining_balance: u64,
        timestamp: u64,
    }

    struct DSACreated has copy, drop {
        sale_id: 0x2::object::ID,
        dsa_id: 0x1::string::String,
        agent_address: address,
        percentage_share: u16,
        timestamp: u64,
    }

    struct DSAUpdated has copy, drop {
        sale_id: 0x2::object::ID,
        dsa_id: 0x1::string::String,
        old_percentage: u16,
        new_percentage: u16,
        timestamp: u64,
    }

    struct DSAStatusChanged has copy, drop {
        sale_id: 0x2::object::ID,
        dsa_id: 0x1::string::String,
        old_status: bool,
        new_status: bool,
        timestamp: u64,
    }

    struct DSARevoked has copy, drop {
        sale_id: 0x2::object::ID,
        dsa_id: 0x1::string::String,
        agent_address: address,
        timestamp: u64,
    }

    struct DSACommissionPaid has copy, drop {
        sale_id: 0x2::object::ID,
        dsa_id: 0x1::string::String,
        agent_address: address,
        commission_amount: u64,
        from_purchase: address,
        timestamp: u64,
    }

    struct DSARewardsClaimed<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        dsa_id: 0x1::string::String,
        agent_address: address,
        amount: u64,
        timestamp: u64,
    }

    public entry fun add_tokens<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 11);
        assert!(arg2 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg1, arg2, arg4)));
        let v0 = TokensAdded<T0>{
            sale_id           : 0x2::object::uid_to_inner(&arg0.id),
            amount_added      : arg2,
            new_token_balance : 0x2::balance::value<T0>(&arg0.token_balance),
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensAdded<T0>>(v0);
    }

    public entry fun buy_tokens<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.status == 0, 1);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0, 4);
        let v2 = v1 / arg0.token_price;
        assert!(v2 > 0, 4);
        let v3 = (v2 as u128) * 0x1::u128::pow(10, arg0.sale_token_decimals);
        assert!(v3 <= (18446744073709551615 as u128), 14);
        let v4 = (v3 as u64);
        assert!(safe_add(arg0.total_sold, v4) <= arg0.max_supply, 5);
        assert!(0x2::balance::value<T0>(&arg0.token_balance) >= v4, 13);
        let v5 = 0x2::object::uid_to_inner(&arg0.id);
        let v6 = 0x2::clock::timestamp_ms(arg3);
        let v7 = DSATableKey{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&mut arg0.id, v7);
        assert!(0x2::table::contains<0x1::string::String, DSA>(v8, arg2), 15);
        let v9 = 0x2::table::borrow_mut<0x1::string::String, DSA>(v8, arg2);
        assert!(v9.is_active, 17);
        let v10 = v1 * (v9.percentage_share as u64) / 10000;
        if (v10 > 0) {
            v9.pending_rewards = safe_add(v9.pending_rewards, v10);
            v9.total_earnings = safe_add(v9.total_earnings, v10);
            let v11 = DSACommissionPaid{
                sale_id           : v5,
                dsa_id            : arg2,
                agent_address     : v9.agent_address,
                commission_amount : v10,
                from_purchase     : v0,
                timestamp         : v6,
            };
            0x2::event::emit<DSACommissionPaid>(v11);
        };
        let v12 = UserTableKey{dummy_field: false};
        let v13 = 0x2::dynamic_field::borrow_mut<UserTableKey, 0x2::table::Table<address, UserProfile>>(&mut arg0.id, v12);
        assert!(0x2::table::contains<address, UserProfile>(v13, v0), 9);
        distribute_commissions(v13, v0, v1, &arg0.commission_rates, v5, v6);
        let v14 = 0x2::table::borrow_mut<address, UserProfile>(v13, v0);
        v14.total_purchased = safe_add(v14.total_purchased, v4);
        0x2::balance::join<T1>(&mut arg0.payment_balance, 0x2::coin::into_balance<T1>(arg1));
        arg0.total_sold = safe_add(arg0.total_sold, v4);
        let v15 = TokensPurchased<T0, T1>{
            sale_id        : v5,
            buyer          : v0,
            token_amount   : v4,
            payment_amount : v1,
            timestamp      : v6,
        };
        0x2::event::emit<TokensPurchased<T0, T1>>(v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v4), arg4), v0);
    }

    public entry fun claim_dsa_rewards<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DSATableKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&mut arg0.id, v1);
        assert!(0x2::table::contains<0x1::string::String, DSA>(v2, arg1), 15);
        let v3 = 0x2::table::borrow_mut<0x1::string::String, DSA>(v2, arg1);
        assert!(v0 == v3.agent_address, 11);
        assert!(v3.pending_rewards > 0, 13);
        let v4 = v3.pending_rewards;
        v3.pending_rewards = 0;
        let v5 = DSARewardsClaimed<T1>{
            sale_id       : 0x2::object::uid_to_inner(&arg0.id),
            dsa_id        : arg1,
            agent_address : v3.agent_address,
            amount        : v4,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DSARewardsClaimed<T1>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.payment_balance, v4), arg3), v0);
    }

    public entry fun claim_rewards<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = UserTableKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<UserTableKey, 0x2::table::Table<address, UserProfile>>(&mut arg0.id, v1);
        assert!(0x2::table::contains<address, UserProfile>(v2, v0), 9);
        let v3 = 0x2::table::borrow_mut<address, UserProfile>(v2, v0);
        let v4 = v3.pending_rewards;
        assert!(v4 > 0, 13);
        assert!(0x2::balance::value<T1>(&arg0.payment_balance) >= v4, 13);
        v3.pending_rewards = 0;
        v3.total_referral_earnings = safe_add(v3.total_referral_earnings, v4);
        let v5 = RewardsClaimed<T1>{
            sale_id   : 0x2::object::uid_to_inner(&arg0.id),
            user      : v0,
            amount    : v4,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RewardsClaimed<T1>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.payment_balance, v4), arg2), v0);
    }

    public entry fun close_sale<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 11);
        assert!(arg0.status != 2, 3);
        arg0.status = 2;
        let v0 = SaleStatusChanged{
            sale_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.status,
            new_status : 2,
            changer    : 0x2::tx_context::sender(arg2),
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SaleStatusChanged>(v0);
    }

    public entry fun create_dsa<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: 0x1::string::String, arg2: address, arg3: u16, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.creator, 11);
        assert!(arg3 <= (10000 as u16), 18);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = DSATableKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&mut arg0.id, v1);
        assert!(!0x2::table::contains<0x1::string::String, DSA>(v2, arg1), 16);
        let v3 = DSA{
            id               : arg1,
            agent_address    : arg2,
            percentage_share : arg3,
            is_active        : true,
            total_earnings   : 0,
            pending_rewards  : 0,
            created_at       : v0,
        };
        0x2::table::add<0x1::string::String, DSA>(v2, arg1, v3);
        let v4 = DSACreated{
            sale_id          : 0x2::object::uid_to_inner(&arg0.id),
            dsa_id           : arg1,
            agent_address    : arg2,
            percentage_share : arg3,
            timestamp        : v0,
        };
        0x2::event::emit<DSACreated>(v4);
    }

    public entry fun create_sale<T0, T1>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut SaleRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: vector<u16>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 12);
        assert!(arg4 > 0, 12);
        assert!(arg2 <= arg4, 5);
        assert!(0x1::vector::length<u16>(&arg6) == 5, 10);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 5) {
            let v2 = *0x1::vector::borrow<u16>(&arg6, v1);
            assert!(v2 <= (10000 as u16), 10);
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(v0 < (10000 as u16), 10);
        let v3 = TokenSale<T0, T1>{
            id                  : 0x2::object::new(arg8),
            creator             : 0x2::tx_context::sender(arg8),
            sale_token_type     : 0x1::type_name::get<T0>(),
            payment_token_type  : 0x1::type_name::get<T1>(),
            token_price         : arg3,
            max_supply          : arg4,
            sale_token_decimals : arg5,
            total_sold          : 0,
            status              : 0,
            commission_rates    : arg6,
            token_balance       : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg0, arg2, arg8)),
            payment_balance     : 0x2::balance::zero<T1>(),
            created_at          : 0x2::clock::timestamp_ms(arg7),
        };
        let v4 = UserTableKey{dummy_field: false};
        0x2::dynamic_field::add<UserTableKey, 0x2::table::Table<address, UserProfile>>(&mut v3.id, v4, 0x2::table::new<address, UserProfile>(arg8));
        let v5 = DSATableKey{dummy_field: false};
        0x2::dynamic_field::add<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&mut v3.id, v5, 0x2::table::new<0x1::string::String, DSA>(arg8));
        let v6 = 0x2::object::uid_to_inner(&v3.id);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.sales, v6, true);
        arg1.total_sales = arg1.total_sales + 1;
        let v7 = SaleCreated<T0, T1>{
            sale_id            : v6,
            creator            : 0x2::tx_context::sender(arg8),
            sale_token_type    : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
            payment_token_type : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>()))),
            token_price        : arg3,
            max_supply         : arg4,
            commission_rates   : arg6,
            timestamp          : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<SaleCreated<T0, T1>>(v7);
        0x2::transfer::share_object<TokenSale<T0, T1>>(v3);
    }

    fun distribute_commissions(arg0: &mut 0x2::table::Table<address, UserProfile>, arg1: address, arg2: u64, arg3: &vector<u16>, arg4: 0x2::object::ID, arg5: u64) {
        let v0 = 0x2::table::borrow<address, UserProfile>(arg0, arg1);
        if (0x1::option::is_none<address>(&v0.direct_referrer)) {
            return
        };
        let v1 = *0x1::option::borrow<address>(&v0.direct_referrer);
        let v2 = 0;
        while (v2 < 5 && 0x2::table::contains<address, UserProfile>(arg0, v1)) {
            let v3 = *0x1::vector::borrow<u16>(arg3, (v2 as u64));
            if (v3 > 0) {
                let v4 = arg2 * (v3 as u64) / 10000;
                if (v4 > 0) {
                    let v5 = 0x2::table::borrow_mut<address, UserProfile>(arg0, v1);
                    v5.pending_rewards = safe_add(v5.pending_rewards, v4);
                    let v6 = CommissionDistributed{
                        sale_id           : arg4,
                        from_purchase     : arg1,
                        referrer          : v1,
                        level             : v2 + 1,
                        commission_amount : v4,
                        timestamp         : arg5,
                    };
                    0x2::event::emit<CommissionDistributed>(v6);
                };
            };
            let v7 = 0x2::table::borrow<address, UserProfile>(arg0, v1);
            if (0x1::option::is_some<address>(&v7.direct_referrer)) {
                v1 = *0x1::option::borrow<address>(&v7.direct_referrer);
                v2 = v2 + 1;
            } else {
                break
            };
        };
    }

    public fun get_commission_rates<T0, T1>(arg0: &TokenSale<T0, T1>) : vector<u16> {
        arg0.commission_rates
    }

    public fun get_dsa_info<T0, T1>(arg0: &TokenSale<T0, T1>, arg1: 0x1::string::String) : (address, u16, bool, u64, u64) {
        let v0 = DSATableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&arg0.id, v0);
        if (!0x2::table::contains<0x1::string::String, DSA>(v1, arg1)) {
            return (@0x0, 0, false, 0, 0)
        };
        let v2 = 0x2::table::borrow<0x1::string::String, DSA>(v1, arg1);
        (v2.agent_address, v2.percentage_share, v2.is_active, v2.total_earnings, v2.pending_rewards)
    }

    public fun get_registry_stats(arg0: &SaleRegistry) : (u64, u64) {
        (arg0.total_sales, 0x2::table::length<0x2::object::ID, bool>(&arg0.sales))
    }

    public fun get_sale_info<T0, T1>(arg0: &TokenSale<T0, T1>) : (address, u64, u64, u64, u8, u64, u64) {
        (arg0.creator, arg0.token_price, arg0.max_supply, arg0.total_sold, arg0.status, 0x2::balance::value<T0>(&arg0.token_balance), 0x2::balance::value<T1>(&arg0.payment_balance))
    }

    public fun get_user_profile<T0, T1>(arg0: &TokenSale<T0, T1>, arg1: address) : (0x1::option::Option<address>, u64, u64, u64, vector<u32>) {
        let v0 = UserTableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<UserTableKey, 0x2::table::Table<address, UserProfile>>(&arg0.id, v0);
        if (!0x2::table::contains<address, UserProfile>(v1, arg1)) {
            return (0x1::option::none<address>(), 0, 0, 0, vector[0, 0, 0, 0, 0])
        };
        let v2 = 0x2::table::borrow<address, UserProfile>(v1, arg1);
        (v2.direct_referrer, v2.total_purchased, v2.total_referral_earnings, v2.pending_rewards, v2.level_counts)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SaleRegistry{
            id          : 0x2::object::new(arg0),
            sales       : 0x2::table::new<0x2::object::ID, bool>(arg0),
            total_sales : 0,
        };
        0x2::transfer::share_object<SaleRegistry>(v0);
    }

    public fun is_dsa_active<T0, T1>(arg0: &TokenSale<T0, T1>, arg1: 0x1::string::String) : bool {
        let v0 = DSATableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&arg0.id, v0);
        if (!0x2::table::contains<0x1::string::String, DSA>(v1, arg1)) {
            return false
        };
        0x2::table::borrow<0x1::string::String, DSA>(v1, arg1).is_active
    }

    public fun is_user_registered<T0, T1>(arg0: &TokenSale<T0, T1>, arg1: address) : bool {
        let v0 = UserTableKey{dummy_field: false};
        0x2::table::contains<address, UserProfile>(0x2::dynamic_field::borrow<UserTableKey, 0x2::table::Table<address, UserProfile>>(&arg0.id, v0), arg1)
    }

    public entry fun pause_sale<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 11);
        assert!(arg0.status == 0, 1);
        arg0.status = 1;
        let v0 = SaleStatusChanged{
            sale_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.status,
            new_status : 1,
            changer    : 0x2::tx_context::sender(arg2),
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SaleStatusChanged>(v0);
    }

    public entry fun register_user<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: 0x1::option::Option<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x1::option::is_some<address>(&arg1)) {
            assert!(*0x1::option::borrow<address>(&arg1) != v0, 7);
        };
        let v1 = UserTableKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<UserTableKey, 0x2::table::Table<address, UserProfile>>(&mut arg0.id, v1);
        assert!(!0x2::table::contains<address, UserProfile>(v2, v0), 8);
        if (0x1::option::is_some<address>(&arg1)) {
            assert!(0x2::table::contains<address, UserProfile>(v2, *0x1::option::borrow<address>(&arg1)), 6);
        };
        let v3 = UserProfile{
            user                    : v0,
            direct_referrer         : arg1,
            total_purchased         : 0,
            total_referral_earnings : 0,
            pending_rewards         : 0,
            level_counts            : vector[0, 0, 0, 0, 0],
            registered_at           : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::table::add<address, UserProfile>(v2, v0, v3);
        if (0x1::option::is_some<address>(&arg1)) {
            update_referrer_counts(v2, *0x1::option::borrow<address>(&arg1), 0);
        };
        let v4 = UserRegistered{
            sale_id   : 0x2::object::uid_to_inner(&arg0.id),
            user      : v0,
            referrer  : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UserRegistered>(v4);
    }

    public entry fun revoke_dsa<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 11);
        let v0 = DSATableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&mut arg0.id, v0);
        assert!(0x2::table::contains<0x1::string::String, DSA>(v1, arg1), 15);
        let v2 = 0x2::table::remove<0x1::string::String, DSA>(v1, arg1);
        let v3 = v2.agent_address;
        let v4 = v2.pending_rewards;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.payment_balance, v4), arg3), v3);
        };
        let v5 = DSARevoked{
            sale_id       : 0x2::object::uid_to_inner(&arg0.id),
            dsa_id        : arg1,
            agent_address : v3,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DSARevoked>(v5);
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 14);
        arg0 + arg1
    }

    public fun sale_exists(arg0: &SaleRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.sales, arg1)
    }

    public entry fun toggle_dsa_status<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 11);
        let v0 = DSATableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&mut arg0.id, v0);
        assert!(0x2::table::contains<0x1::string::String, DSA>(v1, arg1), 15);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, DSA>(v1, arg1);
        v2.is_active = !v2.is_active;
        let v3 = DSAStatusChanged{
            sale_id    : 0x2::object::uid_to_inner(&arg0.id),
            dsa_id     : arg1,
            old_status : v2.is_active,
            new_status : v2.is_active,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DSAStatusChanged>(v3);
    }

    public entry fun unpause_sale<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 11);
        assert!(arg0.status == 1, 2);
        arg0.status = 0;
        let v0 = SaleStatusChanged{
            sale_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.status,
            new_status : 0,
            changer    : 0x2::tx_context::sender(arg2),
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SaleStatusChanged>(v0);
    }

    public entry fun update_commission_rates<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: vector<u16>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 11);
        assert!(0x1::vector::length<u16>(&arg1) == 5, 10);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 5) {
            let v2 = *0x1::vector::borrow<u16>(&arg1, v1);
            assert!(v2 <= (10000 as u16), 10);
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(v0 < (10000 as u16), 10);
        arg0.commission_rates = arg1;
        let v3 = CommissionRatesUpdated{
            sale_id   : 0x2::object::uid_to_inner(&arg0.id),
            old_rates : arg0.commission_rates,
            new_rates : arg0.commission_rates,
            updater   : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CommissionRatesUpdated>(v3);
    }

    public entry fun update_dsa_percentage<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: 0x1::string::String, arg2: u16, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 11);
        assert!(arg2 <= (10000 as u16), 18);
        let v0 = DSATableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DSATableKey, 0x2::table::Table<0x1::string::String, DSA>>(&mut arg0.id, v0);
        assert!(0x2::table::contains<0x1::string::String, DSA>(v1, arg1), 15);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, DSA>(v1, arg1);
        v2.percentage_share = arg2;
        let v3 = DSAUpdated{
            sale_id        : 0x2::object::uid_to_inner(&arg0.id),
            dsa_id         : arg1,
            old_percentage : v2.percentage_share,
            new_percentage : arg2,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DSAUpdated>(v3);
    }

    public entry fun update_price<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 11);
        assert!(arg1 > 0, 12);
        arg0.token_price = arg1;
        let v0 = PriceUpdated{
            sale_id   : 0x2::object::uid_to_inner(&arg0.id),
            old_price : arg0.token_price,
            new_price : arg1,
            updater   : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    fun update_referrer_counts(arg0: &mut 0x2::table::Table<address, UserProfile>, arg1: address, arg2: u8) {
        if (arg2 >= 5) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, UserProfile>(arg0, arg1);
        *0x1::vector::borrow_mut<u32>(&mut v0.level_counts, (arg2 as u64)) = *0x1::vector::borrow<u32>(&v0.level_counts, (arg2 as u64)) + 1;
        if (0x1::option::is_some<address>(&v0.direct_referrer)) {
            update_referrer_counts(arg0, *0x1::option::borrow<address>(&v0.direct_referrer), arg2 + 1);
        };
    }

    public entry fun withdraw_proceeds<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 11);
        assert!(arg1 > 0, 4);
        assert!(0x2::balance::value<T1>(&arg0.payment_balance) >= arg1, 13);
        let v0 = ProceedsWithdrawn<T1>{
            sale_id           : 0x2::object::uid_to_inner(&arg0.id),
            amount_withdrawn  : arg1,
            remaining_balance : 0x2::balance::value<T1>(&arg0.payment_balance),
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProceedsWithdrawn<T1>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.payment_balance, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_tokens<T0, T1>(arg0: &mut TokenSale<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 11);
        assert!(arg1 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.token_balance) >= arg1, 13);
        let v0 = TokensWithdrawn<T0>{
            sale_id           : 0x2::object::uid_to_inner(&arg0.id),
            amount_withdrawn  : arg1,
            remaining_balance : 0x2::balance::value<T0>(&arg0.token_balance),
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokensWithdrawn<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

