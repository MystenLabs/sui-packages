module 0x9024639a4c580da16002b024d25df84d15363882bcaed097f56ef9583934800c::launchpad {
    struct Info has copy, drop, store {
        paid_amount: u64,
        claimed_amount: u64,
        is_freeze: bool,
    }

    struct LaunchInfo<phantom T0> has key {
        id: 0x2::object::UID,
        start_at: u64,
        end_at: u64,
        pay_coin_unit: u64,
        total_pay_supply: u64,
        max_supply_each_user: u64,
        total_paid: 0x2::balance::Balance<T0>,
        sold_pay_amount: u64,
        remain_pay_supply: u64,
        launch_cap_id: 0x2::object::ID,
        claim_amount_per_coin_uint: u64,
        claim_start_at: u64,
        claim_balance: 0x2::bag::Bag,
        all_info: 0x2::table::Table<address, Info>,
        users: vector<address>,
        inviters: vector<address>,
    }

    struct LaunchCap has store, key {
        id: 0x2::object::UID,
    }

    struct QueryDataEvent<phantom T0> has copy, drop {
        start_at: u64,
        end_at: u64,
        pay_coin_unit: u64,
        total_pay_supply: u64,
        max_supply_each_user: u64,
        total_paid: u64,
        remain_pay_supply: u64,
        launch_cap_id: 0x2::object::ID,
        claim_amount_per_coin_uint: u64,
        claim_start_at: u64,
        claim_balance: u64,
        claim_coin_type_name: 0x1::type_name::TypeName,
        paid_amount: u64,
        claimed_amount: u64,
    }

    public entry fun claim<T0, T1>(arg0: &mut LaunchInfo<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.claim_start_at, 1003);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<address, Info>(&mut arg0.all_info, v0);
        assert!(v1.paid_amount > 0, 1014);
        assert!(v1.claimed_amount == 0, 1011);
        assert!(!v1.is_freeze, 1013);
        let v2 = 0x9024639a4c580da16002b024d25df84d15363882bcaed097f56ef9583934800c::math_extend::mul_div(arg0.claim_amount_per_coin_uint, v1.paid_amount, arg0.pay_coin_unit);
        assert!(v2 > 0, 1005);
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.claim_balance, 0x1::type_name::get<T1>());
        assert!(v2 <= 0x2::balance::value<T1>(v3), 1012);
        v1.claimed_amount = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(v3, v2, arg2), v0);
    }

    public entry fun create_launch<T0>(arg0: u64, arg1: u64, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        create_launch_internal<T0>(arg0, arg1, get_coin_unit<T0>(arg2), arg3, arg4, 0x1::vector::empty<address>(), arg5);
    }

    fun create_launch_internal<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < arg1, 1002);
        assert!(arg4 > 0 && arg4 < arg3, 1009);
        let v0 = LaunchCap{id: 0x2::object::new(arg6)};
        let v1 = LaunchInfo<T0>{
            id                         : 0x2::object::new(arg6),
            start_at                   : arg0,
            end_at                     : arg1,
            pay_coin_unit              : arg2,
            total_pay_supply           : arg3,
            max_supply_each_user       : arg4,
            total_paid                 : 0x2::balance::zero<T0>(),
            sold_pay_amount            : 0,
            remain_pay_supply          : arg3,
            launch_cap_id              : 0x2::object::uid_to_inner(&v0.id),
            claim_amount_per_coin_uint : 0,
            claim_start_at             : 0,
            claim_balance              : 0x2::bag::new(arg6),
            all_info                   : 0x2::table::new<address, Info>(arg6),
            users                      : 0x1::vector::empty<address>(),
            inviters                   : arg5,
        };
        0x2::transfer::share_object<LaunchInfo<T0>>(v1);
        0x2::transfer::transfer<LaunchCap>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun create_launch_pay_sui(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        create_launch_internal<0x2::sui::SUI>(arg0, arg1, 1000000000, arg2, arg3, arg4, arg5);
    }

    public fun get_coin_unit<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < 0x2::coin::get_decimals<T0>(arg0)) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun get_launch_data<T0, T1>(arg0: &LaunchInfo<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0;
        let v2 = 0;
        if (0x2::table::contains<address, Info>(&arg0.all_info, v0)) {
            let v3 = *0x2::table::borrow<address, Info>(&arg0.all_info, v0);
            v1 = v3.paid_amount;
            v2 = v3.claimed_amount;
        };
        let v4 = 0x1::type_name::get<T1>();
        let v5 = 0;
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.claim_balance, v4)) {
            v5 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.claim_balance, v4));
        };
        let v6 = QueryDataEvent<T0>{
            start_at                   : arg0.start_at,
            end_at                     : arg0.end_at,
            pay_coin_unit              : arg0.pay_coin_unit,
            total_pay_supply           : arg0.total_pay_supply,
            max_supply_each_user       : arg0.max_supply_each_user,
            total_paid                 : 0x2::balance::value<T0>(&arg0.total_paid),
            remain_pay_supply          : arg0.remain_pay_supply,
            launch_cap_id              : arg0.launch_cap_id,
            claim_amount_per_coin_uint : arg0.claim_amount_per_coin_uint,
            claim_start_at             : arg0.claim_start_at,
            claim_balance              : v5,
            claim_coin_type_name       : v4,
            paid_amount                : v1,
            claimed_amount             : v2,
        };
        0x2::event::emit<QueryDataEvent<T0>>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun purchase<T0>(arg0: &mut LaunchInfo<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 1005);
        assert!(v0 > arg0.start_at, 1003);
        assert!(v0 < arg0.end_at, 1004);
        assert!(v1 <= arg0.remain_pay_supply, 1006);
        arg0.sold_pay_amount = arg0.total_pay_supply - arg0.remain_pay_supply;
        let v2 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, Info>(&arg0.all_info, v2)) {
            let v3 = Info{
                paid_amount    : 0,
                claimed_amount : 0,
                is_freeze      : false,
            };
            0x2::table::add<address, Info>(&mut arg0.all_info, v2, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, Info>(&mut arg0.all_info, v2);
        assert!(v4.paid_amount + v1 <= arg0.max_supply_each_user, 1008);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, *0x1::vector::borrow<address>(&arg0.inviters, 0));
        v4.paid_amount = v4.paid_amount + v1;
    }

    public entry fun set_claim_info<T0, T1>(arg0: &mut LaunchInfo<T0>, arg1: &LaunchCap, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T1>) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.launch_cap_id, 1010);
        assert!(arg2 >= arg0.end_at, 1002);
        assert!(arg3 > 0, 1005);
        arg0.claim_start_at = arg2;
        arg0.claim_amount_per_coin_uint = arg3;
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.claim_balance, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.claim_balance, v0), 0x2::coin::into_balance<T1>(arg4));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.claim_balance, v0, 0x2::coin::into_balance<T1>(arg4));
        };
    }

    public entry fun set_purchase_time<T0>(arg0: &mut LaunchInfo<T0>, arg1: &LaunchCap, arg2: u64, arg3: u64) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.launch_cap_id, 1010);
        assert!(arg2 < arg3, 1002);
        assert!(arg3 >= arg0.end_at, 1002);
        arg0.start_at = arg2;
        arg0.end_at = arg3;
    }

    public entry fun set_remain_supply<T0, T1>(arg0: &mut LaunchInfo<T0>, arg1: &LaunchCap, arg2: u64) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.launch_cap_id, 1010);
        assert!(arg2 < arg0.remain_pay_supply, 1015);
        arg0.remain_pay_supply = arg2;
    }

    public entry fun withdraw_purchased_coin<T0>(arg0: &mut LaunchInfo<T0>, arg1: &LaunchCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.launch_cap_id, 1010);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_paid, 0x2::balance::value<T0>(&arg0.total_paid), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

