module 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::payment_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config<phantom T0> has store {
        vault_id: 0x2::object::ID,
        owner: address,
        read_price: u64,
        write_price: u64,
        delete_price: u64,
        revenue: 0x2::balance::Balance<T0>,
        total_payments: u64,
        total_revenue: u64,
        free_reads: u64,
        free_reads_used: 0x2::table::Table<address, u64>,
    }

    struct PaymentPass {
        vault_id: 0x2::object::ID,
        payer: address,
        access_type: u8,
        amount_paid: u64,
        created_at: u64,
    }

    struct PaymentReceived has copy, drop {
        vault_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        access_type: u8,
    }

    struct RevenueWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct PriceUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        read_price: u64,
        write_price: u64,
        delete_price: u64,
    }

    public fun add<T0>(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config<T0>{
            vault_id        : arg2,
            owner           : arg3,
            read_price      : arg4,
            write_price     : arg5,
            delete_price    : arg6,
            revenue         : 0x2::balance::zero<T0>(),
            total_payments  : 0,
            total_revenue   : 0,
            free_reads      : arg7,
            free_reads_used : 0x2::table::new<address, u64>(arg8),
        };
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::add_main_rule<Rule, Config<T0>>(v0, arg0, arg1, v1);
    }

    public fun free_reads_remaining<T0>(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: address) : u64 {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule<Rule, Config<T0>>(v0, arg0);
        let v2 = if (0x2::table::contains<address, u64>(&v1.free_reads_used, arg1)) {
            *0x2::table::borrow<address, u64>(&v1.free_reads_used, arg1)
        } else {
            0
        };
        if (v2 >= v1.free_reads) {
            0
        } else {
            v1.free_reads - v2
        }
    }

    public fun one_cent() : u64 {
        10000
    }

    public fun one_dollar() : u64 {
        1000000
    }

    public fun pay<T0>(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : PaymentPass {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule_mut<Rule, Config<T0>>(v0, arg0, arg1);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = if (arg2 == 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_types::access_type_read()) {
            v1.read_price
        } else if (arg2 == 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_types::access_type_write()) {
            v1.write_price
        } else {
            v1.delete_price
        };
        assert!(0x2::coin::value<T0>(&arg3) >= v3, 0);
        0x2::balance::join<T0>(&mut v1.revenue, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v3, arg4)));
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v2);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        v1.total_payments = v1.total_payments + 1;
        v1.total_revenue = v1.total_revenue + v3;
        let v4 = PaymentReceived{
            vault_id    : v1.vault_id,
            payer       : v2,
            amount      : v3,
            access_type : arg2,
        };
        0x2::event::emit<PaymentReceived>(v4);
        PaymentPass{
            vault_id    : v1.vault_id,
            payer       : v2,
            access_type : arg2,
            amount_paid : v3,
            created_at  : 0x2::tx_context::epoch_timestamp_ms(arg4),
        }
    }

    public fun pending_revenue<T0>(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy) : u64 {
        let v0 = Rule{dummy_field: false};
        0x2::balance::value<T0>(&0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule<Rule, Config<T0>>(v0, arg0).revenue)
    }

    public fun prove<T0>(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessRequest, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg2: PaymentPass, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let PaymentPass {
            vault_id    : v1,
            payer       : v2,
            access_type : v3,
            amount_paid : _,
            created_at  : v5,
        } = arg2;
        assert!(v1 == 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule<Rule, Config<T0>>(v0, arg1).vault_id, 4);
        assert!(v2 == 0x2::tx_context::sender(arg3), 1);
        assert!(v3 == 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::access_type(arg0), 5);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) < v5 + 300000, 3);
        let v6 = Rule{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::add_receipt<Rule>(v6, arg0);
    }

    public fun read_price<T0>(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy) : u64 {
        let v0 = Rule{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule<Rule, Config<T0>>(v0, arg0).read_price
    }

    public fun set_free_reads<T0>(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: u64) {
        let v0 = Rule{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule_mut<Rule, Config<T0>>(v0, arg0, arg1).free_reads = arg2;
    }

    public fun set_prices<T0>(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule_mut<Rule, Config<T0>>(v0, arg0, arg1);
        v1.read_price = arg2;
        v1.write_price = arg3;
        v1.delete_price = arg4;
        let v2 = PriceUpdated{
            vault_id     : v1.vault_id,
            read_price   : arg2,
            write_price  : arg3,
            delete_price : arg4,
        };
        0x2::event::emit<PriceUpdated>(v2);
    }

    public fun ten_cents() : u64 {
        100000
    }

    public fun total_revenue<T0>(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy) : u64 {
        let v0 = Rule{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule<Rule, Config<T0>>(v0, arg0).total_revenue
    }

    public fun use_free_read<T0>(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: &mut 0x2::tx_context::TxContext) : PaymentPass {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule_mut<Rule, Config<T0>>(v0, arg0, arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = if (0x2::table::contains<address, u64>(&v1.free_reads_used, v2)) {
            *0x2::table::borrow<address, u64>(&v1.free_reads_used, v2)
        } else {
            0
        };
        assert!(v3 < v1.free_reads, 0);
        if (0x2::table::contains<address, u64>(&v1.free_reads_used, v2)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut v1.free_reads_used, v2);
            *v4 = *v4 + 1;
        } else {
            0x2::table::add<address, u64>(&mut v1.free_reads_used, v2, 1);
        };
        PaymentPass{
            vault_id    : v1.vault_id,
            payer       : v2,
            access_type : 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_types::access_type_read(),
            amount_paid : 0,
            created_at  : 0x2::tx_context::epoch_timestamp_ms(arg2),
        }
    }

    public fun withdraw<T0>(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule_mut<Rule, Config<T0>>(v0, arg0, arg1);
        let v2 = 0x2::balance::value<T0>(&v1.revenue);
        assert!(v2 > 0, 2);
        let v3 = RevenueWithdrawn{
            vault_id : v1.vault_id,
            owner    : v1.owner,
            amount   : v2,
        };
        0x2::event::emit<RevenueWithdrawn>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v1.revenue), arg2)
    }

    public fun write_price<T0>(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy) : u64 {
        let v0 = Rule{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule<Rule, Config<T0>>(v0, arg0).write_price
    }

    // decompiled from Move bytecode v6
}

