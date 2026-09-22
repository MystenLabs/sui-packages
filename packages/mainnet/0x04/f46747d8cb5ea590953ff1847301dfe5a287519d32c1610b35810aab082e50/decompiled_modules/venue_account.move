module 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::venue_account {
    struct Binding has copy, drop, store {
        account_object_id: 0x2::object::ID,
        account_number: u64,
        registry_id: 0x2::object::ID,
        clearing_house_id: 0x2::object::ID,
        base_oracle_id: 0x2::object::ID,
        collateral_oracle_id: 0x2::object::ID,
        base_feed_id: 0x2::object::ID,
        collateral_feed_id: 0x2::object::ID,
    }

    struct VenueAccount has store {
        binding: Binding,
        checkpoint: 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint,
        admin_cap: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>,
    }

    public(friend) fun checkpoint(arg0: &VenueAccount) : &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint {
        &arg0.checkpoint
    }

    public(friend) fun account_number(arg0: &Binding) : u64 {
        arg0.account_number
    }

    public(friend) fun allocate<T0>(arg0: &VenueAccount, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: u64) {
        assert_market_account<T0>(&arg0.binding, arg1, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &arg0.admin_cap, arg1, arg3);
    }

    fun assert_account<T0>(arg0: &Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1) == arg0.account_object_id, 3);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1) == arg0.account_number, 4);
    }

    fun assert_funding_update_inputs(arg0: &Binding, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(arg0.clearing_house_id == arg1, 6);
        assert!(arg0.base_oracle_id == arg2, 7);
    }

    fun assert_market_account<T0>(arg0: &Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) {
        assert_account<T0>(arg0, arg1);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg2) == arg0.clearing_house_id, 6);
    }

    public(friend) fun assert_object_graph(arg0: &Binding, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID) {
        assert!(arg0.account_object_id == arg1, 3);
        assert!(arg0.account_number == arg2, 4);
        assert!(arg0.registry_id == arg3, 5);
        assert!(arg0.clearing_house_id == arg4, 6);
        assert!(arg0.base_oracle_id == arg5, 7);
        assert!(arg0.collateral_oracle_id == arg6, 8);
        assert!(arg0.base_feed_id == arg7 && arg0.collateral_feed_id == arg8, 10);
    }

    fun assert_oracles(arg0: &Binding, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg1) == arg0.base_oracle_id, 7);
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg2) == arg0.collateral_oracle_id, 8);
    }

    fun assert_registry(arg0: &Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg1) == arg0.registry_id, 5);
    }

    public(friend) fun binding(arg0: &VenueAccount) : Binding {
        arg0.binding
    }

    public(friend) fun deposit<T0>(arg0: &VenueAccount, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x2::coin::Coin<T0>) {
        assert_account<T0>(&arg0.binding, arg1);
        assert_registry(&arg0.binding, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.admin_cap, arg2, arg3);
    }

    public(friend) fun execute_order<T0>(arg0: &VenueAccount, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: bool, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionSummary) {
        assert_market_account<T0>(&arg0.binding, arg1, &arg2);
        assert_oracles(&arg0.binding, arg3, arg4);
        execute_order_with_cap<T0>(&arg0.admin_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public(friend) fun execute_order_with_cap<T0>(arg0: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: bool, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionSummary) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, arg0, arg1, arg3, arg4, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg8, arg9);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_market_order<T0>(&mut v0, arg5, arg6, arg7);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v0, arg0, arg1, false, false)
    }

    fun is_time_to_update_funding(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg2 > 0 && arg0 >= next_funding_update_time_ms(arg1, arg2)
    }

    public(friend) fun new(arg0: Binding, arg1: 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint, arg2: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) : VenueAccount {
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&arg2) == arg0.account_object_id, 2);
        VenueAccount{
            binding    : arg0,
            checkpoint : arg1,
            admin_cap  : arg2,
        }
    }

    public(friend) fun new_binding(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID) : Binding {
        Binding{
            account_object_id    : arg0,
            account_number       : arg1,
            registry_id          : arg2,
            clearing_house_id    : arg3,
            base_oracle_id       : arg4,
            collateral_oracle_id : arg5,
            base_feed_id         : arg6,
            collateral_feed_id   : arg7,
        }
    }

    fun next_funding_update_time_ms(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1 + arg1
    }

    public(friend) fun replace_checkpoint(arg0: &mut VenueAccount, arg1: 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint) {
        arg0.checkpoint = arg1;
    }

    public(friend) fun update_funding_when_due<T0>(arg0: &Binding, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) {
        assert_funding_update_inputs(arg0, 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1), 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg2));
        let (v0, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_params(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1));
        if (is_time_to_update_funding(0x2::clock::timestamp_ms(arg3), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_last_upd_ms(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(arg1)), v0)) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::update_funding<T0>(arg1, arg2, arg3);
        };
    }

    public(friend) fun withdraw<T0>(arg0: &VenueAccount, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_market_account<T0>(&arg0.binding, arg1, arg3);
        assert_registry(&arg0.binding, arg2);
        assert_oracles(&arg0.binding, arg4, arg5);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg1);
        if (v0 < arg6) {
            let v1 = arg6 - v0;
            assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, &arg0.admin_cap, arg1, arg4, arg5, v1, arg7) == v1, 23);
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T0>(arg1, &arg0.admin_cap, arg2, arg6, arg8)
    }

    // decompiled from Move bytecode v7
}

