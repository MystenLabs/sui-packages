module 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::fund {
    struct Fund<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        total_shares: 0x2::balance::Supply<T0>,
        net_assets: u64,
        share_queue: 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::Queue<T0>,
        asset_queue: 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::Queue<T1>,
        config: Config,
    }

    struct Config has copy, drop, store {
        public_purchase: bool,
        public_redeems: bool,
        instant_purchase: bool,
        instant_redeem: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct PURCHASE {
        dummy_field: bool,
    }

    struct REDEEM {
        dummy_field: bool,
    }

    struct MANAGE_FUND {
        dummy_field: bool,
    }

    public fun asset_to_shares<T0, T1>(arg0: &Fund<T0, T1>, arg1: u64) : u64 {
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::ratio_conversion(arg1, 0x2::balance::supply_value<T0>(&arg0.total_shares), arg0.net_assets)
    }

    public fun cancel_purchase<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x2::balance::Balance<T1> {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::WITHDRAW>(arg1, arg2), 2);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::cancel_deposit<T1>(&mut arg0.asset_queue, arg1)
    }

    public fun cancel_redeem<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x2::balance::Balance<T1> {
        if (!arg0.config.public_redeems) {
            assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::WITHDRAW>(&arg0.id, arg2), 2);
        };
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::cancel_deposit<T1>(&mut arg0.asset_queue, arg1)
    }

    public fun create<T0: drop, T1>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : (Fund<T0, T1>, 0x2::coin::CoinMetadata<T0>) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = Config{
            public_purchase  : false,
            public_redeems   : false,
            instant_purchase : false,
            instant_redeem   : false,
        };
        let v3 = Fund<T0, T1>{
            id           : 0x2::object::new(arg6),
            total_shares : 0x2::coin::treasury_into_supply<T0>(v0),
            net_assets   : 0,
            share_queue  : 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::new<T0>(arg6),
            asset_queue  : 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::new<T1>(arg6),
            config       : v2,
        };
        (v3, v1)
    }

    public fun deposit_as_manager<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<MANAGE_FUND>(&arg0.id, arg2), 6);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::direct_deposit<T1>(&mut arg0.asset_queue, arg1);
    }

    public fun destroy<T0, T1>(arg0: Fund<T0, T1>, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg1), 5);
        let Fund {
            id           : v0,
            total_shares : v1,
            net_assets   : _,
            share_queue  : v3,
            asset_queue  : v4,
            config       : _,
        } = arg0;
        let v6 = v1;
        0x2::object::delete(v0);
        0x2::balance::decrease_supply<T0>(&mut v6, 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::destroy<T0>(v3));
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::immutable::freeze_<0x2::balance::Supply<T0>>(v6, true, arg2);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::destroy<T1>(v4)
    }

    public fun instant_purchase<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x2::balance::Balance<T0> {
        if (!arg0.config.public_purchase) {
            assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<PURCHASE>(&arg0.id, arg2), 0);
        };
        assert!(arg0.config.instant_purchase, 3);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::direct_deposit<T1>(&mut arg0.asset_queue, arg1);
        0x2::balance::increase_supply<T0>(&mut arg0.total_shares, asset_to_shares<T0, T1>(arg0, 0x2::balance::value<T1>(&arg1)))
    }

    public fun instant_purchase_result<T0, T1>(arg0: &Fund<T0, T1>, arg1: u64) : (bool, u64) {
        if (!arg0.config.instant_purchase) {
            return (false, 0)
        };
        (true, asset_to_shares<T0, T1>(arg0, arg1))
    }

    public fun instant_redeem<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x2::balance::Balance<T1> {
        if (!arg0.config.public_redeems) {
            assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<REDEEM>(&arg0.id, arg2), 1);
        };
        assert!(arg0.config.instant_redeem, 4);
        0x2::balance::decrease_supply<T0>(&mut arg0.total_shares, arg1);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::direct_withdraw<T1>(&mut arg0.asset_queue, shares_to_asset<T0, T1>(arg0, 0x2::balance::value<T0>(&arg1)))
    }

    public fun instant_redeem_result<T0, T1>(arg0: &Fund<T0, T1>, arg1: u64) : (bool, u64) {
        if (!arg0.config.instant_redeem) {
            return (false, 0)
        };
        let v0 = shares_to_asset<T0, T1>(arg0, arg1);
        if (v0 <= reserves_available<T0, T1>(arg0)) {
            return (true, v0)
        };
        (false, 0)
    }

    public fun process_orders<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<MANAGE_FUND>(&arg0.id, arg1), 6);
        arg0.net_assets = arg0.net_assets + 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::deposit_input_mint_output<T0, T1>(&mut arg0.asset_queue, &mut arg0.share_queue, arg0.net_assets, 0x2::balance::supply_value<T0>(&arg0.total_shares), &mut arg0.total_shares);
        let (_, v1) = 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::burn_input_withdraw_output<T0, T1>(&mut arg0.asset_queue, &mut arg0.share_queue, arg0.net_assets, 0x2::balance::supply_value<T0>(&arg0.total_shares), &mut arg0.total_shares);
        arg0.net_assets = arg0.net_assets - v1;
    }

    public fun queue_purchase<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: address, arg2: 0x2::balance::Balance<T1>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        if (!arg0.config.public_purchase) {
            assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<PURCHASE>(&arg0.id, arg3), 0);
        };
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::deposit<T1>(&mut arg0.asset_queue, arg1, arg2);
    }

    public fun queue_redeem<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        if (!arg0.config.public_redeems) {
            assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<REDEEM>(&arg0.id, arg3), 1);
        };
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::deposit<T0>(&mut arg0.share_queue, arg1, arg2);
    }

    public fun reserves_available<T0, T1>(arg0: &Fund<T0, T1>) : u64 {
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::reserves_available<T1>(&arg0.asset_queue)
    }

    public fun return_and_share<T0, T1>(arg0: Fund<T0, T1>, arg1: address) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin_with_package_witness<Witness, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::INITIALIZE>(v0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::as_shared_object<Fund<T0, T1>, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::org_transfer::OrgTransfer>(&mut arg0.id, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::new<Fund<T0, T1>>(&arg0), arg1, &v1);
        0x2::transfer::share_object<Fund<T0, T1>>(arg0);
    }

    public fun shares_to_asset<T0, T1>(arg0: &Fund<T0, T1>, arg1: u64) : u64 {
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::ratio_conversion(arg1, arg0.net_assets, 0x2::balance::supply_value<T0>(&arg0.total_shares))
    }

    public fun update_config<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<MANAGE_FUND>(&arg0.id, arg5), 6);
        let v0 = Config{
            public_purchase  : arg1,
            public_redeems   : arg2,
            instant_purchase : arg3,
            instant_redeem   : arg4,
        };
        arg0.config = v0;
    }

    public fun update_net_assets<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: u64, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<MANAGE_FUND>(&arg0.id, arg2), 6);
        arg0.net_assets = arg1;
    }

    public fun withdraw_as_manager<T0, T1>(arg0: &mut Fund<T0, T1>, arg1: u64, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x2::balance::Balance<T1> {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<MANAGE_FUND>(&arg0.id, arg2), 6);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue::direct_withdraw<T1>(&mut arg0.asset_queue, arg1)
    }

    // decompiled from Move bytecode v6
}

