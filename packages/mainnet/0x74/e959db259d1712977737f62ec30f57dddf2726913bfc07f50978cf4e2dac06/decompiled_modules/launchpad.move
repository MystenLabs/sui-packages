module 0x74e959db259d1712977737f62ec30f57dddf2726913bfc07f50978cf4e2dac06::launchpad {
    struct Launchpad has key {
        id: 0x2::object::UID,
    }

    struct Deposit has copy, drop, store {
        user: address,
        amount: u64,
    }

    struct LaunchpadStorage has key {
        id: 0x2::object::UID,
        total_deposit: u64,
        total_nemo: u64,
        balance_nemo: 0x2::balance::Balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        deposits: 0x2::bag::Bag,
        start_at: u64,
        end_at: u64,
        price_numerator: u64,
        price_denominator: u64,
        is_withdrawn: bool,
        vault: address,
    }

    struct WhitelistStorage has key {
        id: 0x2::object::UID,
        whitelist: 0x2::bag::Bag,
        total_deposit: u64,
        start_at: u64,
        end_at: u64,
        price_numerator: u64,
        price_denominator: u64,
        balance_nemo: 0x2::balance::Balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        vault: address,
    }

    struct Whitelist has copy, drop, store {
        user: address,
        amount: u64,
    }

    struct Commited has copy, drop {
        user: address,
        amount: u64,
    }

    struct Claimed has copy, drop {
        user: address,
        sui_amount: u64,
        nemo_amount: u64,
    }

    public fun calculate_nemo_out(arg0: &LaunchpadStorage, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::bag::contains<address>(&arg0.deposits, 0x2::tx_context::sender(arg1))) {
            return 0
        };
        let v0 = arg0.total_deposit;
        let v1 = arg0.total_nemo;
        if (v0 < v1 * price_numerator(arg0) / price_denominator(arg0)) {
            return 0x2::bag::borrow<address, Deposit>(&arg0.deposits, 0x2::tx_context::sender(arg1)).amount * price_denominator(arg0) / price_numerator(arg0)
        };
        (((0x2::bag::borrow<address, Deposit>(&arg0.deposits, 0x2::tx_context::sender(arg1)).amount as u128) * (v1 as u128) / (v0 as u128)) as u64)
    }

    public fun calculate_nemo_out_wl(arg0: &WhitelistStorage, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::bag::contains<address>(&arg0.whitelist, 0x2::tx_context::sender(arg1))) {
            return 0
        };
        0x2::bag::borrow<address, Whitelist>(&arg0.whitelist, 0x2::tx_context::sender(arg1)).amount * price_denominator_wl(arg0) / price_numerator_wl(arg0)
    }

    public fun calculate_pay_amount(arg0: &LaunchpadStorage, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg0.total_deposit < arg0.total_nemo * price_numerator(arg0) / price_denominator(arg0)) {
            return (0x2::bag::borrow<address, Deposit>(&arg0.deposits, 0x2::tx_context::sender(arg1)).amount as u64)
        };
        (calculate_nemo_out(arg0, arg1) as u64) * price_numerator(arg0) / price_denominator(arg0)
    }

    public entry fun claim(arg0: &mut LaunchpadStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= end_timestamp(arg0), 2);
        let v0 = calculate_pay_amount(arg0, arg2);
        let v1 = calculate_nemo_out(arg0, arg2);
        assert!(v1 > 0, 4);
        let v2 = 0x2::bag::remove<address, Deposit>(&mut arg0.deposits, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>>(0x2::coin::from_balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(0x2::balance::split<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg0.balance_nemo, v1), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_sui, v2.amount - v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_wl(arg0: &mut WhitelistStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= end_timestamp_wl(arg0), 2);
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg2)), 7);
        let v0 = 0x2::bag::remove<address, Whitelist>(&mut arg0.whitelist, 0x2::tx_context::sender(arg2));
        let v1 = v0.amount * arg0.price_denominator / arg0.price_numerator;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>>(0x2::coin::from_balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(0x2::balance::split<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg0.balance_nemo, v1), arg2), 0x2::tx_context::sender(arg2));
        let v2 = Claimed{
            user        : 0x2::tx_context::sender(arg2),
            sui_amount  : 0,
            nemo_amount : v1,
        };
        0x2::event::emit<Claimed>(v2);
    }

    public entry fun commit_sui(arg0: &mut LaunchpadStorage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= start_timestamp(arg0), 0);
        assert!(v0 <= end_timestamp(arg0), 1);
        assert!(arg2 >= 10000000000, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg4)));
        if (!0x2::bag::contains<address>(&arg0.deposits, 0x2::tx_context::sender(arg4))) {
            let v1 = Deposit{
                user   : 0x2::tx_context::sender(arg4),
                amount : 0,
            };
            0x2::bag::add<address, Deposit>(&mut arg0.deposits, 0x2::tx_context::sender(arg4), v1);
        };
        let v2 = 0x2::bag::borrow_mut<address, Deposit>(&mut arg0.deposits, 0x2::tx_context::sender(arg4));
        v2.amount = v2.amount + arg2;
        arg0.total_deposit = arg0.total_deposit + arg2;
        let v3 = Commited{
            user   : 0x2::tx_context::sender(arg4),
            amount : arg2,
        };
        0x2::event::emit<Commited>(v3);
    }

    public entry fun commit_sui_wl(arg0: &mut WhitelistStorage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= start_timestamp_wl(arg0), 0);
        assert!(v0 <= end_timestamp_wl(arg0), 1);
        assert!(arg2 >= 10000000000, 3);
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg4)), 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg4)));
        arg0.total_deposit = arg0.total_deposit + arg2;
        let v1 = 0x2::bag::borrow_mut<address, Whitelist>(&mut arg0.whitelist, 0x2::tx_context::sender(arg4));
        v1.amount = v1.amount + arg2;
        let v2 = Commited{
            user   : 0x2::tx_context::sender(arg4),
            amount : arg2,
        };
        0x2::event::emit<Commited>(v2);
    }

    public entry fun deposit_nemo(arg0: &Launchpad, arg1: &mut LaunchpadStorage, arg2: 0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>>(arg2, 0x2::tx_context::sender(arg4));
        0x2::balance::join<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg1.balance_nemo, 0x2::coin::into_balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(0x2::coin::split<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg2, arg3, arg4)));
        arg1.total_nemo = arg1.total_nemo + arg3;
    }

    public entry fun deposit_nemo_wl(arg0: &Launchpad, arg1: &mut WhitelistStorage, arg2: 0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>>(arg2, 0x2::tx_context::sender(arg4));
        0x2::balance::join<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg1.balance_nemo, 0x2::coin::into_balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(0x2::coin::split<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg2, arg3, arg4)));
    }

    public fun end_timestamp(arg0: &LaunchpadStorage) : u64 {
        arg0.end_at
    }

    public fun end_timestamp_wl(arg0: &WhitelistStorage) : u64 {
        arg0.end_at
    }

    public fun get_deposit(arg0: &LaunchpadStorage, arg1: &0x2::tx_context::TxContext) : u64 {
        if (!0x2::bag::contains<address>(&arg0.deposits, 0x2::tx_context::sender(arg1))) {
            return 0
        };
        0x2::bag::borrow<address, Deposit>(&arg0.deposits, 0x2::tx_context::sender(arg1)).amount
    }

    public fun get_deposit_wl(arg0: &WhitelistStorage, arg1: &0x2::tx_context::TxContext) : u64 {
        if (!0x2::bag::contains<address>(&arg0.whitelist, 0x2::tx_context::sender(arg1))) {
            return 0
        };
        0x2::bag::borrow<address, Whitelist>(&arg0.whitelist, 0x2::tx_context::sender(arg1)).amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad{id: 0x2::object::new(arg0)};
        let v1 = LaunchpadStorage{
            id                : 0x2::object::new(arg0),
            total_deposit     : 0,
            total_nemo        : 0,
            balance_nemo      : 0x2::balance::zero<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(),
            balance_sui       : 0x2::balance::zero<0x2::sui::SUI>(),
            deposits          : 0x2::bag::new(arg0),
            start_at          : 1685628000000,
            end_at            : 1688220000000,
            price_numerator   : 1,
            price_denominator : 100,
            is_withdrawn      : false,
            vault             : @0xe6f939e7e54542b6b4f832588a62002d9a9360b54a4a303aa824cb10d5d69fcf,
        };
        let v2 = WhitelistStorage{
            id                : 0x2::object::new(arg0),
            whitelist         : 0x2::bag::new(arg0),
            total_deposit     : 0,
            start_at          : 1685628000000,
            end_at            : 1688220000000,
            price_numerator   : 1,
            price_denominator : 100,
            balance_nemo      : 0x2::balance::zero<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(),
            balance_sui       : 0x2::balance::zero<0x2::sui::SUI>(),
            vault             : @0xe6f939e7e54542b6b4f832588a62002d9a9360b54a4a303aa824cb10d5d69fcf,
        };
        let v3 = Deposit{
            user   : @0xe6f939e7e54542b6b4f832588a62002d9a9360b54a4a303aa824cb10d5d69fcf,
            amount : 0,
        };
        0x2::bag::add<address, Deposit>(&mut v1.deposits, @0xe6f939e7e54542b6b4f832588a62002d9a9360b54a4a303aa824cb10d5d69fcf, v3);
        0x2::transfer::transfer<Launchpad>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<LaunchpadStorage>(v1);
        0x2::transfer::share_object<WhitelistStorage>(v2);
    }

    public fun is_whitelisted(arg0: &WhitelistStorage, arg1: address) : bool {
        0x2::bag::contains<address>(&arg0.whitelist, arg1)
    }

    public entry fun modify_storage_price(arg0: &Launchpad, arg1: &mut LaunchpadStorage, arg2: u64, arg3: u64) {
        arg1.price_numerator = arg2;
        arg1.price_denominator = arg3;
    }

    public entry fun modify_storage_time(arg0: &Launchpad, arg1: &mut LaunchpadStorage, arg2: u64, arg3: u64) {
        arg1.start_at = arg2;
        arg1.end_at = arg3;
    }

    public entry fun modify_vault(arg0: &Launchpad, arg1: &mut LaunchpadStorage, arg2: &mut WhitelistStorage, arg3: address) {
        arg1.vault = arg3;
        arg2.vault = arg3;
    }

    public entry fun modify_wl_storage_price(arg0: &Launchpad, arg1: &mut WhitelistStorage, arg2: u64, arg3: u64) {
        arg1.price_numerator = arg2;
        arg1.price_denominator = arg3;
    }

    public entry fun modify_wl_storage_time(arg0: &Launchpad, arg1: &mut WhitelistStorage, arg2: u64, arg3: u64) {
        arg1.start_at = arg2;
        arg1.end_at = arg3;
    }

    public fun price_denominator(arg0: &LaunchpadStorage) : u64 {
        arg0.price_denominator
    }

    public fun price_denominator_wl(arg0: &WhitelistStorage) : u64 {
        arg0.price_denominator
    }

    public fun price_numerator(arg0: &LaunchpadStorage) : u64 {
        arg0.price_numerator
    }

    public fun price_numerator_wl(arg0: &WhitelistStorage) : u64 {
        arg0.price_numerator
    }

    public entry fun set_wl(arg0: &Launchpad, arg1: &mut WhitelistStorage, arg2: vector<address>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            if (arg3) {
                let v1 = Whitelist{
                    user   : v0,
                    amount : 0,
                };
                0x2::bag::add<address, Whitelist>(&mut arg1.whitelist, v0, v1);
                continue
            };
            if (is_whitelisted(arg1, v0)) {
                0x2::bag::remove<address, Whitelist>(&mut arg1.whitelist, v0);
            };
        };
    }

    public fun start_timestamp(arg0: &LaunchpadStorage) : u64 {
        arg0.start_at
    }

    public fun start_timestamp_wl(arg0: &WhitelistStorage) : u64 {
        arg0.start_at
    }

    public entry fun sync(arg0: &Launchpad, arg1: &mut LaunchpadStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 % 10000;
        arg1.total_deposit = arg1.total_deposit + v0 * 1000000000;
        let v1 = 0x2::bag::borrow_mut<address, Deposit>(&mut arg1.deposits, arg1.vault);
        v1.amount = v1.amount + v0 * 1000000000;
    }

    public entry fun vault_withdraw(arg0: &Launchpad, arg1: &mut LaunchpadStorage, arg2: &mut WhitelistStorage, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_sui, arg3), arg5), arg1.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.balance_sui, arg4), arg5), arg2.vault);
    }

    public entry fun vault_withdraw_nemo(arg0: &Launchpad, arg1: &mut LaunchpadStorage, arg2: &mut WhitelistStorage, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>>(0x2::coin::from_balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(0x2::balance::split<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg1.balance_nemo, arg3), arg5), arg1.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>>(0x2::coin::from_balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(0x2::balance::split<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg2.balance_nemo, arg4), arg5), arg2.vault);
    }

    public entry fun withdraw(arg0: &Launchpad, arg1: &mut LaunchpadStorage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) > end_timestamp(arg1), 2);
        assert!(!arg1.is_withdrawn, 4);
        let v0 = price_numerator(arg1);
        let v1 = price_denominator(arg1);
        let v2 = 0x2::bag::borrow_mut<address, Deposit>(&mut arg1.deposits, arg1.vault);
        let v3 = arg1.total_deposit;
        let v4 = arg1.total_nemo;
        let v5 = if (v3 > v4 * v0 / v1) {
            ((((v3 - v2.amount) as u128) * (v4 as u128) * (v0 as u128) / (v1 as u128) / (v3 as u128)) as u64)
        } else {
            v3 - v2.amount
        };
        arg1.is_withdrawn = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>>(0x2::coin::from_balance<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(0x2::balance::split<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>(&mut arg1.balance_nemo, v4 - v5 * v1 / v0), arg3), arg1.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_sui, v5), arg3), arg1.vault);
        v2.amount = 0;
    }

    public entry fun withdraw_sui_wl(arg0: &Launchpad, arg1: &mut WhitelistStorage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance_sui);
        assert!(0x2::clock::timestamp_ms(arg2) > end_timestamp_wl(arg1), 2);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_sui, v0), arg3), arg1.vault);
    }

    // decompiled from Move bytecode v6
}

