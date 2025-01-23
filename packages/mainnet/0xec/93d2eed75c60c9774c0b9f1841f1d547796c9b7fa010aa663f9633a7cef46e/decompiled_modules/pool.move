module 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin_id: 0x2::object::ID,
        acc: 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::AccumulationDistributor,
        farm_key: 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::FarmMemberKey,
    }

    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        position: 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::Position,
        balance: 0x2::balance::Balance<T0>,
    }

    struct TopUpTicket {
        withdraw_all_ticket: 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::MemberWithdrawAllTicket,
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) : (Pool<T0>, AdminCap) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Pool<T0>{
            id       : 0x2::object::new(arg0),
            admin_id : 0x2::object::id<AdminCap>(&v0),
            acc      : 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::create(arg0),
            farm_key : 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::create_member_key(arg0),
        };
        (v1, v0)
    }

    public fun deposit_shares<T0>(arg0: &mut Pool<T0>, arg1: &mut Stake<T0>, arg2: 0x2::balance::Balance<T0>, arg3: TopUpTicket) {
        destroy_top_up_ticket<T0>(arg0, arg3);
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::deposit_shares(&mut arg0.acc, &mut arg1.position, 0x2::balance::value<T0>(&arg2));
        0x2::balance::join<T0>(&mut arg1.balance, arg2);
    }

    public fun deposit_shares_new<T0>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T0>, arg2: TopUpTicket, arg3: &mut 0x2::tx_context::TxContext) : Stake<T0> {
        destroy_top_up_ticket<T0>(arg0, arg2);
        Stake<T0>{
            id       : 0x2::object::new(arg3),
            position : 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::deposit_shares_new(&mut arg0.acc, 0x2::balance::value<T0>(&arg1)),
            balance  : arg1,
        }
    }

    public fun top_up<T0, T1>(arg0: &mut 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::Farm<T0>, arg1: &mut Pool<T1>, arg2: &mut TopUpTicket, arg3: &0x2::clock::Clock) {
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::top_up<T0>(&mut arg1.acc, 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::member_withdraw_all_with_ticket<T0>(arg0, &mut arg2.withdraw_all_ticket, arg3));
    }

    public fun total_shares<T0>(arg0: &Pool<T0>) : u64 {
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::total_shares(&arg0.acc)
    }

    public fun withdraw_shares<T0>(arg0: &mut Pool<T0>, arg1: &mut Stake<T0>, arg2: u64, arg3: TopUpTicket) : 0x2::balance::Balance<T0> {
        destroy_top_up_ticket<T0>(arg0, arg3);
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::withdraw_shares(&mut arg0.acc, &mut arg1.position, arg2);
        0x2::balance::split<T0>(&mut arg1.balance, arg2)
    }

    public fun redeem_forceful_removal_receipt<T0, T1>(arg0: &mut Pool<T1>, arg1: &mut 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::ForcefulRemovalReceipt<T0>) {
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::top_up<T0>(&mut arg0.acc, 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::redeem_forceful_removal_receipt<T0>(arg1, &mut arg0.farm_key));
    }

    public fun add_to_farm<T0, T1>(arg0: &0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::AdminCap, arg1: &mut 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::Farm<T0>, arg2: &AdminCap, arg3: &mut Pool<T1>, arg4: u32, arg5: &0x2::clock::Clock) {
        assert_admin_cap<T1>(arg3, arg2);
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::add_member<T0>(arg0, arg1, &mut arg3.farm_key, arg4, arg5);
    }

    fun assert_admin_cap<T0>(arg0: &Pool<T0>, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<AdminCap>(arg1) == &arg0.admin_id, 0);
    }

    public fun collect_all_rewards<T0, T1>(arg0: &mut Pool<T1>, arg1: &mut Stake<T1>, arg2: TopUpTicket) : 0x2::balance::Balance<T0> {
        destroy_top_up_ticket<T1>(arg0, arg2);
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::withdraw_all_rewards<T0>(&mut arg0.acc, &mut arg1.position)
    }

    public fun collect_rewards<T0, T1>(arg0: &mut Pool<T1>, arg1: &mut Stake<T1>, arg2: u64, arg3: TopUpTicket) : 0x2::balance::Balance<T0> {
        destroy_top_up_ticket<T1>(arg0, arg3);
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::withdraw_rewards<T0>(&mut arg0.acc, &mut arg1.position, arg2)
    }

    public fun collect_rewards_direct<T0, T1>(arg0: &mut Pool<T1>, arg1: &mut Stake<T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::withdraw_rewards_direct<T0>(&mut arg0.acc, &mut arg1.position, arg2)
    }

    public fun create_and_add_to_farm<T0, T1>(arg0: &0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::AdminCap, arg1: &mut 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::Farm<T0>, arg2: u32, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : AdminCap {
        let (v0, v1) = create<T1>(arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        add_to_farm<T0, T1>(arg0, arg1, &v2, v4, arg2, arg3);
        0x2::transfer::share_object<Pool<T1>>(v3);
        v2
    }

    public fun create_and_share<T0>(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let (v0, v1) = create<T0>(arg0);
        0x2::transfer::share_object<Pool<T0>>(v0);
        v1
    }

    public fun destroy_admin_cap_irreversibly_i_know_what_im_doing(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_empty_stake<T0>(arg0: Stake<T0>) {
        let Stake {
            id       : v0,
            position : v1,
            balance  : v2,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v2);
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::position_destroy_empty(v1);
    }

    fun destroy_top_up_ticket<T0>(arg0: &mut Pool<T0>, arg1: TopUpTicket) {
        let TopUpTicket { withdraw_all_ticket: v0 } = arg1;
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::destroy_withdraw_all_ticket(v0, &mut arg0.farm_key);
    }

    public fun farm_key_id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        0x2::object::id<0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::FarmMemberKey>(&arg0.farm_key)
    }

    public fun merge_stakes<T0>(arg0: &mut Pool<T0>, arg1: &mut Stake<T0>, arg2: Stake<T0>) {
        let Stake {
            id       : v0,
            position : v1,
            balance  : v2,
        } = arg2;
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::merge_positions(&mut arg0.acc, &mut arg1.position, v1);
        0x2::object::delete(v0);
        0x2::balance::join<T0>(&mut arg1.balance, v2);
    }

    public fun new_top_up_ticket<T0>(arg0: &mut Pool<T0>) : TopUpTicket {
        TopUpTicket{withdraw_all_ticket: 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::new_withdraw_all_ticket(&mut arg0.farm_key)}
    }

    public fun remove_from_farm<T0, T1>(arg0: &AdminCap, arg1: &mut 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::Farm<T0>, arg2: &mut Pool<T1>, arg3: &0x2::clock::Clock) {
        assert_admin_cap<T1>(arg2, arg0);
        0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor::top_up<T0>(&mut arg2.acc, 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::farm::remove_member<T0>(arg1, &mut arg2.farm_key, arg3));
    }

    public fun stake_balance<T0>(arg0: &Stake<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun update_and_merge_stakes<T0>(arg0: &mut Pool<T0>, arg1: &mut Stake<T0>, arg2: Stake<T0>, arg3: TopUpTicket) {
        destroy_top_up_ticket<T0>(arg0, arg3);
        merge_stakes<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

