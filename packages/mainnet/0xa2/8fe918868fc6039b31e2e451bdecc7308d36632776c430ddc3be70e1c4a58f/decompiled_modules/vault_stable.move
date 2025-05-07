module 0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::vault_stable {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        total_usdc: u64,
        current_epoch_reward_amount: u64,
        total_kusd: u64,
        pending_fund: u64,
        current_epoch: u64,
        total_pending_burned_kusd: u64,
        epoch_history: 0x2::table::Table<u64, EpochData>,
        deposit_requests: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, DepositRequest>>,
        withdraw_requests: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, WithdrawRequest>>,
        kusd_cap: 0x2::coin::TreasuryCap<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD>,
        withdraw_lock_time: u64,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct EpochData has copy, drop, store {
        timestamp: u64,
        epoch: u64,
        exchange_dp_rate: u128,
        exchange_wd_rate: u128,
        reward: u64,
        reserve_usdc: u64,
        total_withdraw_usdc: u64,
        total_deposit_usdc: u64,
    }

    struct DepositRequest has drop, store {
        user: address,
        usdc_amount: u64,
        epoch: u64,
    }

    struct WithdrawRequest has drop, store {
        user: address,
        kusd_amount: u64,
        epoch: u64,
    }

    struct ClaimEvent has copy, drop, store {
        user: address,
        amount: u64,
        epoch: u64,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        amount: u64,
        epoch: u64,
    }

    struct WithdrawRequestedEvent has copy, drop, store {
        user: address,
        kusd_amount: u64,
        epoch: u64,
    }

    struct WithdrawClaimedEvent has copy, drop, store {
        user: address,
        usdc_amount: u64,
        epoch: u64,
    }

    struct IncreaseRewardEvent has copy, drop, store {
        epoch: u64,
        amount: u64,
    }

    struct DecreaseRewardEvent has copy, drop, store {
        epoch: u64,
        amount: u64,
    }

    struct OperatorDepositLiquidityEvent has copy, drop, store {
        epoch: u64,
        amount: u64,
    }

    struct OperatorWithdrawLiquidityEvent has copy, drop, store {
        epoch: u64,
        amount: u64,
    }

    fun calculate_vault_info(arg0: &mut Vault) : (u128, u128, u128, u64) {
        let v0 = if (arg0.total_kusd == 0 || arg0.total_usdc == 0) {
            1000000000000000000
        } else {
            (arg0.total_usdc as u128) * 1000000000000000000 / (arg0.total_kusd as u128)
        };
        let v1 = if (arg0.total_kusd == 0 || arg0.total_usdc == 0) {
            1000000000000000000
        } else {
            (arg0.total_usdc as u128) * 1000000000000000000 / (arg0.total_kusd as u128)
        };
        let v2 = (arg0.total_pending_burned_kusd as u128) * v0 / 1000000000000000000;
        arg0.total_kusd = arg0.total_kusd - arg0.total_pending_burned_kusd;
        arg0.total_usdc = arg0.total_usdc - (v2 as u64);
        arg0.total_pending_burned_kusd = 0;
        arg0.total_kusd = arg0.total_kusd + (((arg0.pending_fund as u128) * 1000000000000000000 / v1) as u64);
        arg0.total_usdc = arg0.total_usdc + arg0.pending_fund;
        arg0.pending_fund = 0;
        (v1, v0, v2, arg0.pending_fund)
    }

    public entry fun claim_and_transfer_kusd(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1010);
        let v0 = claim_kusd(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun claim_and_transfer_usdc(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1010);
        let v0 = claim_usdc(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun claim_kusd(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD> {
        assert!(arg0.version == 1, 1010);
        assert!(!arg0.paused, 1006);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, DepositRequest>>(&arg0.deposit_requests, v0), 1002);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, DepositRequest>>(&mut arg0.deposit_requests, v0);
        while (v2 < 0x2::linked_table::length<u64, DepositRequest>(v3)) {
            let (v4, v5) = 0x2::linked_table::pop_front<u64, DepositRequest>(v3);
            let v6 = v5;
            if (v4 < arg0.current_epoch) {
                v1 = v1 + (((v6.usdc_amount as u128) * 1000000000000000000 / 0x2::table::borrow<u64, EpochData>(&arg0.epoch_history, v4).exchange_dp_rate) as u64);
            } else {
                0x2::linked_table::push_back<u64, DepositRequest>(v3, v4, v6);
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 1003);
        let v7 = ClaimEvent{
            user   : v0,
            amount : v1,
            epoch  : arg0.current_epoch,
        };
        0x2::event::emit<ClaimEvent>(v7);
        0x2::coin::mint<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD>(&mut arg0.kusd_cap, v1, arg1)
    }

    public fun claim_usdc(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(arg0.version == 1, 1010);
        assert!(!arg0.paused, 1006);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, WithdrawRequest>>(&arg0.withdraw_requests, v0), 1002);
        let v1 = 0;
        let v2 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, WithdrawRequest>>(&mut arg0.withdraw_requests, v0);
        let v3 = 0;
        while (v1 < 0x2::linked_table::length<u64, WithdrawRequest>(v2)) {
            let (v4, v5) = 0x2::linked_table::pop_front<u64, WithdrawRequest>(v2);
            let v6 = v5;
            let v7 = 0x2::table::borrow<u64, EpochData>(&arg0.epoch_history, v4);
            if (v4 < arg0.current_epoch && 0x2::clock::timestamp_ms(arg1) - v7.timestamp > arg0.withdraw_lock_time) {
                v3 = v3 + (((v6.kusd_amount as u128) * v7.exchange_wd_rate / 1000000000000000000) as u64);
            } else {
                0x2::linked_table::push_back<u64, WithdrawRequest>(v2, v4, v6);
            };
            v1 = v1 + 1;
        };
        assert!(v3 > 0, 1003);
        assert!(v3 < 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance), 1007);
        let v8 = WithdrawClaimedEvent{
            user        : v0,
            usdc_amount : v3,
            epoch       : arg0.current_epoch,
        };
        0x2::event::emit<WithdrawClaimedEvent>(v8);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v3), arg2)
    }

    public entry fun decrease_reward(arg0: &mut Vault, arg1: &OperatorCap, arg2: u64) {
        assert!(arg0.version == 1, 1010);
        assert!(arg0.current_epoch_reward_amount > arg2, 1011);
        arg0.total_usdc = arg0.total_usdc - arg2;
        arg0.current_epoch_reward_amount = arg0.current_epoch_reward_amount - arg2;
        let v0 = DecreaseRewardEvent{
            epoch  : arg0.current_epoch,
            amount : arg2,
        };
        0x2::event::emit<DecreaseRewardEvent>(v0);
    }

    public entry fun deposit_usdc(arg0: &mut Vault, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1010);
        assert!(!arg0.paused, 1006);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v0 > 0, 1001);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        let v1 = 0x2::tx_context::sender(arg2);
        arg0.pending_fund = arg0.pending_fund + v0;
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, DepositRequest>>(&arg0.deposit_requests, v1)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, DepositRequest>>(&mut arg0.deposit_requests, v1, 0x2::linked_table::new<u64, DepositRequest>(arg2));
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, DepositRequest>>(&mut arg0.deposit_requests, v1);
        let v3 = arg0.current_epoch;
        if (0x2::linked_table::contains<u64, DepositRequest>(v2, v3)) {
            let v4 = 0x2::linked_table::borrow_mut<u64, DepositRequest>(v2, v3);
            v4.usdc_amount = v4.usdc_amount + v0;
        } else {
            let v5 = DepositRequest{
                user        : v1,
                usdc_amount : v0,
                epoch       : v3,
            };
            0x2::linked_table::push_back<u64, DepositRequest>(v2, v3, v5);
        };
        let v6 = DepositEvent{
            user   : v1,
            amount : v0,
            epoch  : arg0.current_epoch,
        };
        0x2::event::emit<DepositEvent>(v6);
    }

    public entry fun end_epoch(arg0: &mut Vault, arg1: &OperatorCap, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 1010);
        let (v0, v1, v2, v3) = calculate_vault_info(arg0);
        let v4 = arg0.current_epoch;
        let v5 = EpochData{
            timestamp           : 0x2::clock::timestamp_ms(arg2),
            epoch               : v4,
            exchange_dp_rate    : v0,
            exchange_wd_rate    : v1,
            reward              : arg0.current_epoch_reward_amount,
            reserve_usdc        : arg0.total_usdc,
            total_withdraw_usdc : (v2 as u64),
            total_deposit_usdc  : v3,
        };
        0x2::table::add<u64, EpochData>(&mut arg0.epoch_history, v4, v5);
        arg0.current_epoch_reward_amount = 0;
        arg0.current_epoch = arg0.current_epoch + 1;
    }

    public(friend) fun get_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public(friend) fun get_deposit_request_size(arg0: &Vault) : u64 {
        0x2::table::length<address, 0x2::linked_table::LinkedTable<u64, DepositRequest>>(&arg0.deposit_requests)
    }

    public fun get_epoch_history(arg0: &Vault, arg1: u64, arg2: u64, arg3: u64) : vector<EpochData> {
        assert!(arg0.version == 1, 1010);
        assert!(arg0.current_epoch > 0, 1012);
        assert!(arg3 == 0 || arg3 == 1, 1013);
        let v0 = 0x1::vector::empty<EpochData>();
        let v1 = arg0.current_epoch;
        let v2 = 0;
        let v3 = if (arg3 == 0) {
            arg1
        } else {
            v1 - 1 - arg1
        };
        let v4 = v3;
        while (v2 < arg2 && (arg3 == 0 && v4 < v1 || arg3 == 1 && v4 >= 0)) {
            0x1::vector::push_back<EpochData>(&mut v0, *0x2::table::borrow<u64, EpochData>(&arg0.epoch_history, v4));
            if (arg3 == 0) {
                v4 = v4 + 1;
            } else {
                if (v4 == 0) {
                    break
                };
                v4 = v4 - 1;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun get_pending_fund(arg0: &Vault) : u64 {
        arg0.pending_fund
    }

    public(friend) fun get_total_burned_kusd(arg0: &Vault) : u64 {
        arg0.total_pending_burned_kusd
    }

    public(friend) fun get_total_kusd(arg0: &Vault) : u64 {
        arg0.total_kusd
    }

    public(friend) fun get_total_usdc(arg0: &Vault) : u64 {
        arg0.total_usdc
    }

    public(friend) fun get_withdraw_request_size(arg0: &Vault) : u64 {
        0x2::table::length<address, 0x2::linked_table::LinkedTable<u64, WithdrawRequest>>(&arg0.withdraw_requests)
    }

    public entry fun increase_reward(arg0: &mut Vault, arg1: &OperatorCap, arg2: u64) {
        assert!(arg0.version == 1, 1010);
        assert!(arg0.total_usdc + arg0.pending_fund > 0, 1008);
        arg0.total_usdc = arg0.total_usdc + arg2;
        arg0.current_epoch_reward_amount = arg0.current_epoch_reward_amount + arg2;
        let v0 = IncreaseRewardEvent{
            epoch  : arg0.current_epoch,
            amount : arg2,
        };
        0x2::event::emit<IncreaseRewardEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun init_vault(arg0: 0x2::coin::TreasuryCap<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id                          : 0x2::object::new(arg2),
            version                     : 1,
            paused                      : false,
            balance                     : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            total_usdc                  : 0,
            current_epoch_reward_amount : 0,
            total_kusd                  : 0,
            pending_fund                : 0,
            current_epoch               : 0,
            total_pending_burned_kusd   : 0,
            epoch_history               : 0x2::table::new<u64, EpochData>(arg2),
            deposit_requests            : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, DepositRequest>>(arg2),
            withdraw_requests           : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, WithdrawRequest>>(arg2),
            kusd_cap                    : arg0,
            withdraw_lock_time          : arg1,
        }
    }

    public entry fun migrate(arg0: &mut Vault, arg1: &OperatorCap) {
        assert!(arg0.version < 1, 1009);
        arg0.version = 1;
    }

    public entry fun operator_deposit_liquidity(arg0: &mut Vault, arg1: &OperatorCap, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        assert!(arg0.version == 1, 1010);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        let v0 = OperatorDepositLiquidityEvent{
            epoch  : arg0.current_epoch,
            amount : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2),
        };
        0x2::event::emit<OperatorDepositLiquidityEvent>(v0);
    }

    public entry fun operator_init_vault(arg0: 0x2::coin::TreasuryCap<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD>, arg1: &OperatorCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault>(init_vault(arg0, arg2, arg3));
    }

    public entry fun operator_withdraw_liquidity(arg0: &mut Vault, arg1: &OperatorCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1010);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = OperatorWithdrawLiquidityEvent{
            epoch  : arg0.current_epoch,
            amount : arg2,
        };
        0x2::event::emit<OperatorWithdrawLiquidityEvent>(v0);
    }

    public entry fun pause_vault(arg0: &mut Vault, arg1: &OperatorCap) {
        assert!(arg0.version == 1, 1010);
        arg0.paused = true;
    }

    public entry fun request_withdraw(arg0: &mut Vault, arg1: 0x2::coin::Coin<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1010);
        assert!(!arg0.paused, 1006);
        let v0 = 0x2::coin::value<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD>(&arg1);
        assert!(v0 > 0, 1004);
        assert!(arg0.total_kusd > 0, 1005);
        let v1 = 0x2::tx_context::sender(arg2);
        arg0.total_pending_burned_kusd = arg0.total_pending_burned_kusd + v0;
        0x2::coin::burn<0xa28fe918868fc6039b31e2e451bdecc7308d36632776c430ddc3be70e1c4a58f::kusd::KUSD>(&mut arg0.kusd_cap, arg1);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, WithdrawRequest>>(&arg0.withdraw_requests, v1)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, WithdrawRequest>>(&mut arg0.withdraw_requests, v1, 0x2::linked_table::new<u64, WithdrawRequest>(arg2));
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, WithdrawRequest>>(&mut arg0.withdraw_requests, v1);
        let v3 = arg0.current_epoch;
        if (0x2::linked_table::contains<u64, WithdrawRequest>(v2, v3)) {
            let v4 = 0x2::linked_table::borrow_mut<u64, WithdrawRequest>(v2, v3);
            v4.kusd_amount = v4.kusd_amount + v0;
        } else {
            let v5 = WithdrawRequest{
                user        : v1,
                kusd_amount : v0,
                epoch       : v3,
            };
            0x2::linked_table::push_back<u64, WithdrawRequest>(v2, v3, v5);
        };
        let v6 = WithdrawRequestedEvent{
            user        : v1,
            kusd_amount : v0,
            epoch       : arg0.current_epoch,
        };
        0x2::event::emit<WithdrawRequestedEvent>(v6);
    }

    public entry fun unpause_vault(arg0: &mut Vault, arg1: &OperatorCap) {
        assert!(arg0.version == 1, 1010);
        arg0.paused = false;
    }

    public entry fun update_withdraw_lock_time(arg0: &mut Vault, arg1: &OperatorCap, arg2: u64) {
        assert!(arg0.version == 1, 1010);
        arg0.withdraw_lock_time = arg2;
    }

    // decompiled from Move bytecode v6
}

