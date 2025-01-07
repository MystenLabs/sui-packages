module 0x386a0e6aba0abcc1527560632ad5803b8a80e0d8649cbc4d06325c0c0478a8f1::mine {
    struct MINE has drop {
        dummy_field: bool,
    }

    struct NetValueEvent<phantom T0> has copy, drop, store {
        net_value: u64,
    }

    struct Bank<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        shares: 0x2::balance::Balance<T1>,
        net_value: u64,
        total_shares: u64,
        premium_rate: u64,
        house_cut: u64,
        min_bet: u64,
        max_bet: u64,
        status: u64,
        decimals: u64,
        vip_level_scale: u64,
    }

    struct Odds has store, key {
        id: 0x2::object::UID,
        values: vector<u64>,
    }

    struct NewWin<phantom T0> has copy, drop, store {
        player: address,
        win: u64,
    }

    struct NewPlay<phantom T0> has copy, drop, store {
        amount: u64,
    }

    struct Ticket<phantom T0> has store, key {
        id: 0x2::object::UID,
        game: u64,
        gem_amount: u64,
        gem_number: u64,
        bomb_number: u64,
        bet: u64,
        win: u64,
    }

    struct TotalStake<phantom T0> has copy, drop, store {
        total_stake: u64,
    }

    struct VipLevel<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        premium: u64,
        level: u64,
        amount: u64,
        promotion_amount: u64,
        amount_to_next_level: u64,
        claimed: u64,
    }

    struct NewVip<phantom T0> has copy, drop, store {
        vip_id: 0x2::object::ID,
        owner: address,
    }

    struct AirdorpBank<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        amount_1: u64,
        amount_2: u64,
        amount_3: u64,
        amount_4: u64,
        amount_5: u64,
    }

    fun delete<T0>(arg0: Ticket<T0>) {
        let Ticket {
            id          : v0,
            game        : _,
            gem_amount  : _,
            gem_number  : _,
            bomb_number : _,
            bet         : _,
            win         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun mine<T0, T1>(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: u64, arg4: &mut Bank<T0, T1>, arg5: &mut VipLevel<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 1, 2);
        assert!(arg3 < arg1, 2);
        assert!(arg4.status == 1, 4);
        assert!(arg2 >= arg4.min_bet, 2);
        assert!(arg2 <= arg4.max_bet, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::random::new_generator(arg0, arg6);
        let v2 = 0x2::random::new_generator(arg0, arg6);
        let v3 = Ticket<T0>{
            id          : 0x2::object::new(arg6),
            game        : arg1,
            gem_amount  : arg3,
            gem_number  : 0x2::random::generate_u64_in_range(&mut v1, 1, arg1),
            bomb_number : 0x2::random::generate_u64_in_range(&mut v2, 1, arg1 - 1),
            bet         : arg2,
            win         : 0,
        };
        if (v3.bomb_number >= v3.gem_number) {
            v3.bomb_number = v3.bomb_number + 1;
        };
        if (v3.gem_number < v3.bomb_number && v3.gem_number <= arg3) {
            let v4 = arg2 * 2 * arg1 * (arg1 - 1) / (2 * arg1 - arg3 - 1) / arg3 - arg2;
            v3.win = v4 * (100 - arg4.house_cut - arg4.premium_rate) / 100 + arg2;
            arg5.premium = arg5.premium + v4 * arg5.level / 100;
            arg4.net_value = ((((arg4.net_value as u128) * (arg4.total_shares as u128) - (v4 as u128) * ((100 - arg4.premium_rate - arg5.level) as u128) * (1000000000 as u128) / 100) / (arg4.total_shares as u128)) as u64);
            let v5 = NewWin<T0>{
                player : v0,
                win    : v3.win,
            };
            0x2::event::emit<NewWin<T0>>(v5);
        } else {
            arg5.premium = arg5.premium + arg2 * arg5.level / 100;
            arg4.net_value = arg4.net_value + (((arg2 as u128) * ((100 - arg4.house_cut + arg5.level) as u128) * (1000000000 as u128) / 100 / (arg4.total_shares as u128)) as u64);
        };
        handle_vip<T0, T1>(arg4, arg5, arg2, v0);
        0x2::transfer::public_transfer<Ticket<T0>>(v3, v0);
    }

    entry fun add_shares_to_bank<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        assert!(0x2::coin::value<T1>(&arg2) > 0, 0);
        0x2::balance::join<T1>(&mut arg1.shares, 0x2::coin::into_balance<T1>(arg2));
    }

    entry fun add_to_airdorp_bank<T0, T1>(arg0: &mut AirdorpBank<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun add_to_bank<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        let v0 = (0x2::coin::value<T0>(&arg1) as u128) * (1000000000 as u128) / (arg0.net_value as u128);
        assert!(v0 <= (0x2::balance::value<T1>(&arg0.shares) as u128), 2);
        arg0.total_shares = arg0.total_shares + (v0 as u64);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        assert!((v0 as u64) > 0, 2);
        assert!((v0 as u64) <= 0x2::balance::value<T1>(&arg0.shares), 2);
        let v1 = TotalStake<T0>{total_stake: arg0.total_shares};
        0x2::event::emit<TotalStake<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.shares, (v0 as u64), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun autoset_premium_rate<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        arg1.premium_rate = 500000 * 1000000000 / arg1.total_shares * 1000000000 / arg1.net_value;
        if (arg1.premium_rate >= 20) {
            arg1.premium_rate = 20;
        };
        if (arg1.premium_rate <= 5) {
            arg1.premium_rate = 5;
        };
    }

    entry fun claim_airdrop<T0, T1>(arg0: &mut AirdorpBank<T0, T1>, arg1: &mut VipLevel<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.claimed == 0, 5);
        assert!(arg1.level >= 1, 6);
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 1);
        let v0 = 0;
        let v1 = 0;
        if (arg1.level == 1) {
            v0 = arg0.amount_1;
            v1 = 1;
        };
        if (arg1.level == 2) {
            v0 = arg0.amount_2;
            v1 = 2;
        };
        if (arg1.level == 3) {
            v0 = arg0.amount_3;
            v1 = 3;
        };
        if (arg1.level == 4) {
            v0 = arg0.amount_4;
            v1 = 4;
        };
        if (arg1.level == 5) {
            v0 = arg0.amount_5;
            v1 = 5;
        };
        if (arg1.claimed == 1) {
            v0 = v0 - arg0.amount_1;
        };
        if (arg1.claimed == 2) {
            v0 = v0 - arg0.amount_2;
        };
        if (arg1.claimed == 3) {
            v0 = v0 - arg0.amount_3;
        };
        if (arg1.claimed == 4) {
            v0 = v0 - arg0.amount_4;
        };
        if (arg1.claimed == 5) {
            v0 = v0 - arg0.amount_5;
        };
        arg1.claimed = v1;
        assert!(v0 > 0, 2);
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.balance), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun create_airdorp_bank<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        let v0 = AirdorpBank<T0, T1>{
            id       : 0x2::object::new(arg1),
            balance  : 0x2::balance::zero<T0>(),
            amount_1 : 1000,
            amount_2 : 10000,
            amount_3 : 100000,
            amount_4 : 1000000,
            amount_5 : 10000000,
        };
        0x2::transfer::public_share_object<AirdorpBank<T0, T1>>(v0);
    }

    entry fun create_bank<T0, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        let v0 = Bank<T0, T1>{
            id              : 0x2::object::new(arg3),
            balance         : 0x2::balance::zero<T0>(),
            shares          : 0x2::balance::zero<T1>(),
            net_value       : 1000000000,
            total_shares    : 0,
            premium_rate    : 20,
            house_cut       : 1,
            min_bet         : arg1,
            max_bet         : arg1,
            status          : 1,
            decimals        : arg1,
            vip_level_scale : arg2,
        };
        let v1 = NetValueEvent<T0>{net_value: v0.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v1);
        0x2::transfer::public_share_object<Bank<T0, T1>>(v0);
    }

    entry fun create_odds(arg0: &0x2::package::Publisher, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        let v0 = Odds{
            id     : 0x2::object::new(arg2),
            values : arg1,
        };
        0x2::transfer::public_share_object<Odds>(v0);
    }

    entry fun get_new_vip<T0, T1>(arg0: &Bank<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = VipLevel<T0>{
            id                   : 0x2::object::new(arg1),
            owner                : v0,
            premium              : 0,
            level                : 0,
            amount               : 0,
            promotion_amount     : 0,
            amount_to_next_level : 100 * arg0.decimals,
            claimed              : 0,
        };
        let v2 = NewVip<T0>{
            vip_id : 0x2::object::id<VipLevel<T0>>(&v1),
            owner  : v0,
        };
        0x2::event::emit<NewVip<T0>>(v2);
        0x2::transfer::public_share_object<VipLevel<T0>>(v1);
    }

    fun handle_vip<T0, T1>(arg0: &Bank<T0, T1>, arg1: &mut VipLevel<T0>, arg2: u64, arg3: address) {
        arg1.amount = arg1.amount + arg2;
        if (arg1.owner != arg3) {
            arg1.promotion_amount = arg1.promotion_amount + arg2;
        };
        if (arg1.amount < 1 * arg0.decimals * arg0.vip_level_scale) {
            arg1.level = 0;
        };
        if (arg1.amount >= 1 * arg0.decimals * arg0.vip_level_scale) {
            arg1.level = 1;
        };
        if (arg1.amount >= 10 * arg0.decimals * arg0.vip_level_scale) {
            arg1.level = 2;
        };
        if (arg1.amount >= 100 * arg0.decimals * arg0.vip_level_scale) {
            arg1.level = 3;
        };
        if (arg1.amount >= 1000 * arg0.decimals * arg0.vip_level_scale) {
            arg1.level = 4;
        };
        if (arg1.amount >= 10000 * arg0.decimals * arg0.vip_level_scale) {
            arg1.level = 5;
        };
        if (arg1.level == 0) {
            arg1.amount_to_next_level = 1 * arg0.decimals * arg0.vip_level_scale - arg1.amount;
        };
        if (arg1.level == 1) {
            arg1.amount_to_next_level = 10 * arg0.decimals * arg0.vip_level_scale - arg1.amount;
        };
        if (arg1.level == 2) {
            arg1.amount_to_next_level = 100 * arg0.decimals * arg0.vip_level_scale - arg1.amount;
        };
        if (arg1.level == 3) {
            arg1.amount_to_next_level = 1000 * arg0.decimals * arg0.vip_level_scale - arg1.amount;
        };
        if (arg1.level == 4) {
            arg1.amount_to_next_level = 10000 * arg0.decimals * arg0.vip_level_scale - arg1.amount;
        };
        if (arg1.level == 5) {
            arg1.amount_to_next_level = 0;
        };
    }

    fun init(arg0: MINE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MINE>(arg0, arg1);
    }

    entry fun mine_16<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        mine<T0, T1>(arg0, 16, v0, arg3, arg1, arg4, arg5);
        pay<T0, T1>(arg1, arg2);
        let v1 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v1);
        let v2 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v2);
    }

    entry fun mine_16x10<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 10) {
            mine<T0, T1>(arg0, 16, v0 / 10, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    entry fun mine_16x100<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 100) {
            mine<T0, T1>(arg0, 16, v0 / 100, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    entry fun mine_16x1000<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 1000) {
            mine<T0, T1>(arg0, 16, v0 / 1000, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    entry fun mine_25<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        mine<T0, T1>(arg0, 25, v0, arg3, arg1, arg4, arg5);
        pay<T0, T1>(arg1, arg2);
        let v1 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v1);
        let v2 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v2);
    }

    entry fun mine_25x10<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 10) {
            mine<T0, T1>(arg0, 25, v0 / 10, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    entry fun mine_25x100<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 100) {
            mine<T0, T1>(arg0, 25, v0 / 100, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    entry fun mine_25x1000<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 1000) {
            mine<T0, T1>(arg0, 25, v0 / 1000, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    entry fun mine_36<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        mine<T0, T1>(arg0, 36, v0, arg3, arg1, arg4, arg5);
        pay<T0, T1>(arg1, arg2);
        let v1 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v1);
        let v2 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v2);
    }

    entry fun mine_36x10<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 10) {
            mine<T0, T1>(arg0, 36, v0 / 10, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    entry fun mine_36x100<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 100) {
            mine<T0, T1>(arg0, 36, v0 / 100, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    entry fun mine_36x1000<T0, T1>(arg0: &0x2::random::Random, arg1: &mut Bank<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut VipLevel<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 1;
        while (v1 <= 1000) {
            mine<T0, T1>(arg0, 36, v0 / 1000, arg3, arg1, arg4, arg5);
            v1 = v1 + 1;
        };
        pay<T0, T1>(arg1, arg2);
        let v2 = NetValueEvent<T0>{net_value: arg1.net_value};
        0x2::event::emit<NetValueEvent<T0>>(v2);
        let v3 = NewPlay<T0>{amount: v0};
        0x2::event::emit<NewPlay<T0>>(v3);
    }

    fun pay<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.min_bet, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun redeem<T0, T1>(arg0: Ticket<T0>, arg1: &mut Bank<T0, T1>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.win == 0) {
            delete<T0>(arg0);
        } else {
            0x386a0e6aba0abcc1527560632ad5803b8a80e0d8649cbc4d06325c0c0478a8f1::suichat::emit_new_msg(0x2::tx_context::sender(arg3), b"win", arg0.win, b"Congratulations on winning the grand prize!", arg2);
            redeem_from_bank<T0, T1>(arg1, arg0.win, arg3);
            delete<T0>(arg0);
        };
    }

    fun redeem_from_bank<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 3);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.balance), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun redeem_vip_premium<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: &mut VipLevel<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 1);
        let v0 = arg1.premium;
        assert!(v0 > 0, 3);
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.balance), 2);
        arg1.premium = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun remove_all_from_airdorp_bank<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut AirdorpBank<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun remove_from_bank<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 4);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        assert!(0x2::coin::value<T1>(&arg1) <= arg0.total_shares, 2);
        arg0.total_shares = arg0.total_shares - 0x2::coin::value<T1>(&arg1);
        let v0 = (0x2::coin::value<T1>(&arg1) as u128) * (arg0.net_value as u128) / (1000000000 as u128);
        0x2::balance::join<T1>(&mut arg0.shares, 0x2::coin::into_balance<T1>(arg1));
        assert!((v0 as u64) > 0, 2);
        assert!((v0 as u64) <= 0x2::balance::value<T0>(&arg0.balance), 2);
        let v1 = TotalStake<T0>{total_stake: arg0.total_shares};
        0x2::event::emit<TotalStake<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, (v0 as u64), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun remove_housecut_from_bank<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance) - arg1.net_value * arg1.total_shares, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun remove_shares_from_bank<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        let v0 = 0x2::balance::value<T1>(&arg1.shares);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.shares, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun set_house_cut<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: u64) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        arg1.house_cut = arg2;
    }

    entry fun set_max_bet<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: u64) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        arg1.max_bet = arg2;
    }

    entry fun set_min_bet<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: u64) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        arg1.min_bet = arg2;
    }

    entry fun set_odds(arg0: &0x2::package::Publisher, arg1: &mut Odds, arg2: vector<u64>) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        arg1.values = arg2;
    }

    entry fun set_premium_rate<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: u64) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        assert!(arg2 >= 5, 2);
        arg1.premium_rate = arg2;
    }

    entry fun set_status<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: u64) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        arg1.status = arg2;
    }

    entry fun set_vip_level<T0>(arg0: &0x2::package::Publisher, arg1: &mut VipLevel<T0>, arg2: u64) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        arg1.level = arg2;
    }

    entry fun set_vip_level_scale<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0, T1>, arg2: u64) {
        assert!(0x2::package::from_package<MINE>(arg0), 1);
        arg1.vip_level_scale = arg2;
    }

    // decompiled from Move bytecode v6
}

