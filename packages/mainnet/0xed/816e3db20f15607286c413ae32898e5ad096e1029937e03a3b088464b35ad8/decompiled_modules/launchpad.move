module 0xed816e3db20f15607286c413ae32898e5ad096e1029937e03a3b088464b35ad8::launchpad {
    struct UserInfo<phantom T0> has store {
        addr: address,
        amount: u128,
        claimed_amount: u128,
        self_init: bool,
        reffer_address: address,
        reffer_reward_coin: 0x2::coin::Coin<T0>,
        total_reffer_reward: u64,
    }

    struct LaunchPadInfo has key {
        id: 0x2::object::UID,
    }

    struct RefferRewardEvent has copy, drop {
        addr: address,
        reffer_address: address,
        amount: u64,
    }

    struct LaunchPadItem<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        initial_release_ratio: u64,
        line_release_time: u64,
        img_url: 0x1::ascii::String,
        logo_url: 0x1::ascii::String,
        project_name: 0x1::ascii::String,
        project_website: 0x1::ascii::String,
        project_discord: 0x1::ascii::String,
        project_tweet: 0x1::ascii::String,
        project_tg: 0x1::ascii::String,
        project_github: 0x1::ascii::String,
        project_detail: 0x1::ascii::String,
        project_detail_url: 0x1::ascii::String,
        tab_vec: vector<0x1::ascii::String>,
        min_invest_amount: u64,
        max_invest_amount: u64,
        start_time: u64,
        end_time: u64,
        raise_target_amount: u64,
        total_offer_amount: u64,
        raise_pool: 0x2::coin::Coin<T0>,
        offer_pool: 0x2::coin::Coin<T1>,
        raised_amount: u64,
        begin_distribution_time: u64,
        referrer_ratio: u64,
        total_referrer_reward: u64,
    }

    public entry fun add<T0, T1>(arg0: &mut LaunchPadInfo, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::ascii::String, arg15: 0x1::ascii::String, arg16: 0x1::ascii::String, arg17: 0x1::ascii::String, arg18: vector<0x1::ascii::String>, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg19) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        let v0 = 0x2::object::new(arg19);
        let v1 = LaunchPadItem<T0, T1>{
            id                      : v0,
            initial_release_ratio   : arg1,
            line_release_time       : arg2,
            img_url                 : arg8,
            logo_url                : arg9,
            project_name            : arg10,
            project_website         : arg11,
            project_discord         : arg12,
            project_tweet           : arg13,
            project_tg              : arg14,
            project_github          : arg15,
            project_detail          : arg16,
            project_detail_url      : arg17,
            tab_vec                 : arg18,
            min_invest_amount       : 10000000000,
            max_invest_amount       : 30000000000000,
            start_time              : arg3,
            end_time                : arg4,
            raise_target_amount     : arg7,
            total_offer_amount      : arg6,
            raise_pool              : 0x2::coin::zero<T0>(arg19),
            offer_pool              : 0x2::coin::zero<T1>(arg19),
            raised_amount           : 0,
            begin_distribution_time : arg5,
            referrer_ratio          : 3,
            total_referrer_reward   : 0,
        };
        0x2::dynamic_object_field::add<address, LaunchPadItem<T0, T1>>(&mut arg0.id, 0x2::object::uid_to_address(&v0), v1);
    }

    public entry fun claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut LaunchPadInfo, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg1.id, arg2);
        assert!(v2.begin_distribution_time != 0 && v0 >= v2.begin_distribution_time, 1003);
        assert!(0x2::dynamic_field::exists_<address>(&v2.id, v1), 1005);
        let v3 = 0x2::dynamic_field::borrow_mut<address, UserInfo<T0>>(&mut v2.id, v1);
        let v4 = if (v0 - v2.begin_distribution_time >= v2.line_release_time) {
            v2.line_release_time
        } else {
            v0 - v2.begin_distribution_time
        };
        let v5 = v3.amount * (v2.total_offer_amount as u128) / (v2.raise_target_amount as u128);
        let v6 = (v5 as u128) * (v2.initial_release_ratio as u128) / 100;
        let v7 = (v5 - v6) * (v4 as u128) / (v2.line_release_time as u128);
        let v8 = if (v3.claimed_amount > 0) {
            ((v6 + v7) as u128) - v3.claimed_amount
        } else {
            ((v6 + v7) as u128)
        };
        v3.claimed_amount = v3.claimed_amount + v8;
        if (v8 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v2.offer_pool, (v8 as u64), arg3), v1);
        };
    }

    public entry fun claim_reffer_reward<T0, T1>(arg0: &mut LaunchPadInfo, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserInfo<T0>>(&mut 0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg0.id, arg1).id, v0);
        let v2 = 0x2::coin::value<T0>(&v1.reffer_reward_coin);
        assert!(v2 > 0, 1008);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.reffer_reward_coin, v2, arg2), v0);
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        let v0 = LaunchPadInfo{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<LaunchPadInfo>(v0);
    }

    public entry fun inject_offerCoin<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut LaunchPadInfo, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        assert!(0x2::coin::value<T1>(&arg0) > 0, 1002);
        0x2::coin::join<T1>(&mut 0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg1.id, arg2).offer_pool, arg0);
    }

    public entry fun investment<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut LaunchPadInfo, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg2.id, arg3);
        assert!(v0 >= v2.start_time && v0 <= v2.end_time, 1003);
        let v3 = 0x2::coin::value<T0>(&arg0);
        assert!(v3 >= v2.min_invest_amount, 1006);
        v2.raised_amount = v2.raised_amount + v3;
        assert!(v2.raised_amount <= v2.raise_target_amount, 1007);
        if (arg4 == v1) {
            arg4 = @0x0;
        };
        if (0x2::dynamic_field::exists_<address>(&v2.id, v1)) {
            let v4 = 0x2::dynamic_field::borrow_mut<address, UserInfo<T0>>(&mut v2.id, v1);
            v4.amount = v4.amount + (v3 as u128);
            if (v4.self_init) {
                arg4 = v4.reffer_address;
            } else {
                v4.reffer_address = arg4;
                v4.self_init = true;
                if (!0x2::dynamic_field::exists_<address>(&mut v2.id, arg4) && arg4 != @0x0) {
                    let v5 = UserInfo<T0>{
                        addr                : arg4,
                        amount              : 0,
                        claimed_amount      : 0,
                        self_init           : false,
                        reffer_address      : @0x0,
                        reffer_reward_coin  : 0x2::coin::zero<T0>(arg5),
                        total_reffer_reward : 0,
                    };
                    0x2::dynamic_field::add<address, UserInfo<T0>>(&mut v2.id, arg4, v5);
                };
            };
        } else {
            if (!0x2::dynamic_field::exists_<address>(&mut v2.id, arg4) && arg4 != @0x0) {
                let v6 = UserInfo<T0>{
                    addr                : arg4,
                    amount              : 0,
                    claimed_amount      : 0,
                    self_init           : false,
                    reffer_address      : @0x0,
                    reffer_reward_coin  : 0x2::coin::zero<T0>(arg5),
                    total_reffer_reward : 0,
                };
                0x2::dynamic_field::add<address, UserInfo<T0>>(&mut v2.id, arg4, v6);
            };
            let v7 = UserInfo<T0>{
                addr                : v1,
                amount              : (v3 as u128),
                claimed_amount      : 0,
                self_init           : true,
                reffer_address      : arg4,
                reffer_reward_coin  : 0x2::coin::zero<T0>(arg5),
                total_reffer_reward : 0,
            };
            0x2::dynamic_field::add<address, UserInfo<T0>>(&mut v2.id, v1, v7);
        };
        if (arg4 != @0x0) {
            let v8 = 0x2::dynamic_field::borrow_mut<address, UserInfo<T0>>(&mut v2.id, arg4);
            let v9 = v3 * v2.referrer_ratio / 100;
            v8.total_reffer_reward = v8.total_reffer_reward + v9;
            0x2::coin::join<T0>(&mut v8.reffer_reward_coin, 0x2::coin::split<T0>(&mut arg0, v9, arg5));
            v2.total_referrer_reward = v2.total_referrer_reward + v9;
            let v10 = RefferRewardEvent{
                addr           : v1,
                reffer_address : arg4,
                amount         : v9,
            };
            0x2::event::emit<RefferRewardEvent>(v10);
        };
        0x2::coin::join<T0>(&mut v2.raise_pool, arg0);
    }

    fun pay_coin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0 && arg1 > 0, 1002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        let v1 = 0x2::coin::value<T0>(&v0);
        assert!(v1 >= arg1, 1002);
        if (arg1 != v1) {
            0x2::pay::split_and_transfer<T0>(&mut v0, v1 - arg1, 0x2::tx_context::sender(arg2), arg2);
        };
        v0
    }

    public entry fun setRaiseAmount<T0, T1>(arg0: u64, arg1: &mut LaunchPadInfo, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        assert!(arg0 > 0, 1002);
        0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg1.id, arg2).raise_target_amount = arg0;
    }

    public entry fun set_all<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: vector<0x1::ascii::String>, arg14: &mut LaunchPadInfo, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg16) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg14.id, arg15);
        v0.start_time = arg0;
        v0.end_time = arg1;
        v0.total_offer_amount = arg2;
        v0.raise_target_amount = arg3;
        v0.min_invest_amount = arg4;
        v0.img_url = arg5;
        v0.logo_url = arg6;
        v0.project_name = arg7;
        v0.project_website = arg8;
        v0.project_discord = arg9;
        v0.project_tweet = arg10;
        v0.project_detail = arg11;
        v0.project_detail_url = arg12;
        v0.tab_vec = arg13;
    }

    public entry fun set_distribution_time<T0, T1>(arg0: u64, arg1: &mut LaunchPadInfo, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg1.id, arg2).begin_distribution_time = arg0;
    }

    public entry fun set_offer_amount<T0, T1>(arg0: u64, arg1: &mut LaunchPadInfo, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        assert!(arg0 > 0, 1002);
        0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg1.id, arg2).total_offer_amount = arg0;
    }

    public entry fun take_amount<T0, T1>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: &mut LaunchPadInfo, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, LaunchPadItem<T0, T1>>(&mut arg3.id, arg4);
        assert!(v0 == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        assert!(0x2::clock::timestamp_ms(arg0) / 1000 >= v1.end_time, 1003);
        0x2::pay::split_and_transfer<T0>(&mut v1.raise_pool, arg1, v0, arg5);
        0x2::pay::split_and_transfer<T1>(&mut v1.offer_pool, arg2, v0, arg5);
    }

    // decompiled from Move bytecode v6
}

