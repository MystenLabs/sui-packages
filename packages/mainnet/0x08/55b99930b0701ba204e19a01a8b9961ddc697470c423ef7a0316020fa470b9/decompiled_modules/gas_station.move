module 0x855b99930b0701ba204e19a01a8b9961ddc697470c423ef7a0316020fa470b9::gas_station {
    struct GasStation has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
        gas_price: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct AdminAdded has copy, drop {
        admin: address,
        added_by: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
        removed_by: address,
    }

    struct GasPriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
        updated_by: address,
    }

    struct TransactionFeePaid has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct FundsWithdrawn has copy, drop {
        admin: address,
        amount: u64,
    }

    public fun add_admin(arg0: &mut GasStation, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 1);
        assert!(!is_admin(arg0, arg1), 3);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AdminAdded{
            admin    : arg1,
            added_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun get_admin_count(arg0: &GasStation) : u64 {
        0x1::vector::length<address>(&arg0.admins)
    }

    public fun get_admins(arg0: &GasStation) : vector<address> {
        arg0.admins
    }

    public fun get_balance(arg0: &GasStation) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun get_gas_price(arg0: &GasStation) : u64 {
        arg0.gas_price
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GasStation{
            id        : 0x2::object::new(arg0),
            admins    : v0,
            gas_price : 100000,
            balance   : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x2::transfer::share_object<GasStation>(v1);
    }

    public fun is_admin(arg0: &GasStation, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun pay_transaction_fee(arg0: &mut GasStation, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v0 == arg0.gas_price, 5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        let v1 = TransactionFeePaid{
            user      : 0x2::tx_context::sender(arg3),
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TransactionFeePaid>(v1);
    }

    public fun remove_admin(arg0: &mut GasStation, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 1);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        assert!(v0, 4);
        0x1::vector::remove<address>(&mut arg0.admins, v1);
        let v2 = AdminRemoved{
            admin      : arg1,
            removed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminRemoved>(v2);
    }

    public fun set_gas_price(arg0: &mut GasStation, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, v0), 1);
        arg0.gas_price = arg1;
        let v1 = GasPriceUpdated{
            old_price  : arg0.gas_price,
            new_price  : arg1,
            updated_by : v0,
        };
        0x2::event::emit<GasPriceUpdated>(v1);
    }

    public fun withdraw_funds(arg0: &mut GasStation, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 1);
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance);
        assert!(v0 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance), arg1), 0x2::tx_context::sender(arg1));
        let v1 = FundsWithdrawn{
            admin  : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<FundsWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

