module 0xd3c96c3b37c0e8a0aa2a4932522eff523f2afd06a0e3bebda665f7a836b27a21::fee_router {
    struct FeeTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        admin: address,
        fee_bps: u64,
        paused: bool,
    }

    struct FeesWithdrawn<phantom T0> has copy, drop {
        admin: address,
        amount: u64,
        treasury_id: 0x2::object::ID,
    }

    struct FeeCollectedEvent<phantom T0> has copy, drop {
        user: address,
        coin_in_type: 0x1::ascii::String,
        amount_in: u64,
        fee_amount: u64,
    }

    struct FeeUpdated<phantom T0> has copy, drop {
        admin: address,
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct AdminTransferred<phantom T0> has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct TreasuryPauseChanged<phantom T0> has copy, drop {
        admin: address,
        paused: bool,
    }

    public fun get_admin<T0>(arg0: &FeeTreasury<T0>) : address {
        arg0.admin
    }

    public fun get_collected_fees<T0>(arg0: &FeeTreasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_fee_bps<T0>(arg0: &FeeTreasury<T0>) : u64 {
        arg0.fee_bps
    }

    public entry fun init_treasury<T0>(arg0: &0xd3c96c3b37c0e8a0aa2a4932522eff523f2afd06a0e3bebda665f7a836b27a21::sentra::AdminCap, arg1: &0xd3c96c3b37c0e8a0aa2a4932522eff523f2afd06a0e3bebda665f7a836b27a21::sentra::Platform, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xd3c96c3b37c0e8a0aa2a4932522eff523f2afd06a0e3bebda665f7a836b27a21::sentra::AdminCap>(arg0) == 0xd3c96c3b37c0e8a0aa2a4932522eff523f2afd06a0e3bebda665f7a836b27a21::sentra::platform_admin_cap_id(arg1), 1);
        assert!(0x2::tx_context::sender(arg3) == 0xd3c96c3b37c0e8a0aa2a4932522eff523f2afd06a0e3bebda665f7a836b27a21::sentra::get_admin(arg1), 1);
        assert!(arg2 > 0, 3);
        assert!(arg2 <= 500, 2);
        let v0 = FeeTreasury<T0>{
            id      : 0x2::object::new(arg3),
            balance : 0x2::balance::zero<T0>(),
            admin   : 0x2::tx_context::sender(arg3),
            fee_bps : arg2,
            paused  : false,
        };
        0x2::transfer::share_object<FeeTreasury<T0>>(v0);
    }

    public fun is_paused<T0>(arg0: &FeeTreasury<T0>) : bool {
        arg0.paused
    }

    public entry fun set_paused<T0>(arg0: &mut FeeTreasury<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.paused = arg1;
        let v0 = TreasuryPauseChanged<T0>{
            admin  : arg0.admin,
            paused : arg1,
        };
        0x2::event::emit<TreasuryPauseChanged<T0>>(v0);
    }

    public fun take_fee_and_return<T0>(arg0: &mut FeeTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.paused, 4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = (((v0 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg2)));
        let v2 = FeeCollectedEvent<T0>{
            user         : 0x2::tx_context::sender(arg2),
            coin_in_type : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount_in    : v0,
            fee_amount   : v1,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v2);
        arg1
    }

    public entry fun transfer_admin<T0>(arg0: &mut FeeTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
        let v0 = AdminTransferred<T0>{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferred<T0>>(v0);
    }

    public entry fun update_fee<T0>(arg0: &mut FeeTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 > 0, 3);
        assert!(arg1 <= 500, 2);
        arg0.fee_bps = arg1;
        let v0 = FeeUpdated<T0>{
            admin       : arg0.admin,
            old_fee_bps : arg0.fee_bps,
            new_fee_bps : arg1,
        };
        0x2::event::emit<FeeUpdated<T0>>(v0);
    }

    public entry fun withdraw_fees<T0>(arg0: &mut FeeTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 > 0, 5);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.balance), 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), arg0.admin);
        let v0 = FeesWithdrawn<T0>{
            admin       : arg0.admin,
            amount      : arg1,
            treasury_id : 0x2::object::id<FeeTreasury<T0>>(arg0),
        };
        0x2::event::emit<FeesWithdrawn<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

