module 0x7386f28caa297c68acac486ea30bc93d85cde6ea189e15756cd9d34d264fae96::perp_bonus {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        paused: bool,
        whitelist: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct ClaimEvent {
        dummy_field: bool,
    }

    public entry fun admin_deposit(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) > 0, 1);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
    }

    public entry fun admin_update_bonus_amount(arg0: &AdminCap, arg1: &mut Vault, arg2: address, arg3: u64) {
        0x2::table::remove<address, u64>(&mut arg1.whitelist, arg2);
        0x2::table::add<address, u64>(&mut arg1.whitelist, arg2, arg3);
    }

    public entry fun admin_withdraw(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun claim(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x2::table::contains<address, u64>(&arg0.whitelist, arg1), 4);
        0x2::table::remove<address, u64>(&mut arg0.whitelist, arg1);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, *0x2::table::borrow<address, u64>(&arg0.whitelist, arg1)), arg2)
    }

    public entry fun grant_whitelist(arg0: &AdminCap, arg1: &mut Vault, arg2: vector<address>, arg3: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, u64>(&arg1.whitelist, *v1)) {
                0x2::table::add<address, u64>(&mut arg1.whitelist, *v1, *0x1::vector::borrow<u64>(&arg3, v0));
            } else {
                0x2::table::remove<address, u64>(&mut arg1.whitelist, *v1);
                0x2::table::add<address, u64>(&mut arg1.whitelist, *v1, *0x2::table::borrow<address, u64>(&arg1.whitelist, *v1) + *0x1::vector::borrow<u64>(&arg3, v0));
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_vault(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id        : 0x2::object::new(arg1),
            paused    : false,
            whitelist : 0x2::table::new<address, u64>(arg1),
            balance   : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public entry fun is_eligible_bonus(arg0: &Vault, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.whitelist, arg1)
    }

    public entry fun revoke_whitelist(arg0: &AdminCap, arg1: &mut Vault, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            assert!(0x2::table::contains<address, u64>(&arg1.whitelist, *v1), 4);
            0x2::table::remove<address, u64>(&mut arg1.whitelist, *v1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

