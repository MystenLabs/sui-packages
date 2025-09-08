module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::platform_treasury {
    struct PlatformTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        total_platform_fees: u64,
        total_subscription_fees: u64,
    }

    struct TreasuryAdminCap has store, key {
        id: 0x2::object::UID,
        treasury_id: 0x2::object::ID,
    }

    struct PlatformFeeDeposited has copy, drop {
        amount: u64,
        fee_type: 0x1::string::String,
        depositor: address,
        timestamp: u64,
    }

    struct TreasuryWithdrawal has copy, drop {
        amount: u64,
        admin: address,
        timestamp: u64,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
        timestamp: u64,
    }

    public fun deposit_platform_fee(arg0: &mut PlatformTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 202);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (arg2 == 0x1::string::utf8(b"event_registration")) {
            arg0.total_platform_fees = arg0.total_platform_fees + v0;
        } else if (arg2 == 0x1::string::utf8(b"subscription")) {
            arg0.total_subscription_fees = arg0.total_subscription_fees + v0;
        };
        let v1 = PlatformFeeDeposited{
            amount    : v0,
            fee_type  : arg2,
            depositor : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PlatformFeeDeposited>(v1);
    }

    public fun get_fee_totals(arg0: &PlatformTreasury) : (u64, u64) {
        (arg0.total_platform_fees, arg0.total_subscription_fees)
    }

    public fun get_treasury_admin(arg0: &PlatformTreasury) : address {
        arg0.admin
    }

    public fun get_treasury_balance(arg0: &PlatformTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_treasury_details(arg0: &PlatformTreasury) : (u64, address, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.admin, arg0.total_platform_fees, arg0.total_subscription_fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PlatformTreasury{
            id                      : 0x2::object::new(arg0),
            balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            admin                   : v0,
            total_platform_fees     : 0,
            total_subscription_fees : 0,
        };
        let v2 = TreasuryAdminCap{
            id          : 0x2::object::new(arg0),
            treasury_id : 0x2::object::id<PlatformTreasury>(&v1),
        };
        0x2::transfer::transfer<TreasuryAdminCap>(v2, v0);
        0x2::transfer::share_object<PlatformTreasury>(v1);
    }

    public fun is_admin(arg0: &PlatformTreasury, arg1: address) : bool {
        arg0.admin == arg1
    }

    public fun transfer_admin(arg0: &mut PlatformTreasury, arg1: TreasuryAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 200);
        assert!(arg1.treasury_id == 0x2::object::id<PlatformTreasury>(arg0), 200);
        arg0.admin = arg2;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg2,
            timestamp : 0,
        };
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::public_transfer<TreasuryAdminCap>(arg1, arg2);
    }

    public fun withdraw_treasury_funds(arg0: &mut PlatformTreasury, arg1: &TreasuryAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.admin == v0, 200);
        assert!(arg1.treasury_id == 0x2::object::id<PlatformTreasury>(arg0), 200);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 201);
        assert!(arg2 > 0, 202);
        let v1 = TreasuryWithdrawal{
            amount    : arg2,
            admin     : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryWithdrawal>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

