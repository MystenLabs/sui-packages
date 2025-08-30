module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
    }

    struct BillingConfig has key {
        id: 0x2::object::UID,
        treasury_id: address,
        admin: address,
        enabled: bool,
        price_multiplier_bp: u16,
        version: u64,
    }

    public(friend) fun charge(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &BillingConfig, arg3: &mut Treasury, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_billing_enabled(arg2.enabled);
        let v0 = arg1 * (arg2.price_multiplier_bp as u64) / (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::bp_den() as u64);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_price_cap(v0 <= 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::max_billing_price_mist());
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_sufficient_payment(0x2::coin::value<0x2::sui::SUI>(&arg0), v0);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_valid_treasury(0x2::object::uid_to_address(&arg3.id) == arg2.treasury_id);
        0x2::coin::put<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg4));
        arg3.total_collected = arg3.total_collected + v0;
        arg0
    }

    public(friend) fun init_billing(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id              : 0x2::object::new(arg1),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected : 0,
        };
        let v1 = BillingConfig{
            id                  : 0x2::object::new(arg1),
            treasury_id         : 0x2::object::uid_to_address(&v0.id),
            admin               : 0x2::tx_context::sender(arg1),
            enabled             : true,
            price_multiplier_bp : 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::billing_price_multiplier_bp(),
            version             : 1,
        };
        0x2::transfer::share_object<Treasury>(v0);
        0x2::transfer::share_object<BillingConfig>(v1);
    }

    public(friend) fun set_billing_enabled(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut BillingConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.enabled = arg2;
        arg1.version = arg1.version + 1;
    }

    public(friend) fun update_admin(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut BillingConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin = arg2;
        arg1.version = arg1.version + 1;
    }

    public(friend) fun update_price_multiplier(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut BillingConfig, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_price_multiplier_not_too_high(arg2 <= 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::max_price_multiplier_bp());
        arg1.price_multiplier_bp = arg2;
        arg1.version = arg1.version + 1;
    }

    public(friend) fun withdraw_from_treasury(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut Treasury, arg2: &BillingConfig, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_valid_treasury(0x2::object::uid_to_address(&arg1.id) == arg2.treasury_id);
        let v0 = if (0x1::option::is_some<u64>(&arg3)) {
            let v1 = *0x1::option::borrow<u64>(&arg3);
            assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), 0);
            v1
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg1.balance)
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg4), arg2.admin);
        };
    }

    // decompiled from Move bytecode v6
}

