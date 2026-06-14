module 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::platform_fee_vault {
    struct PlatformFeeVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        total_fee_collected: u64,
        total_fee_withdrawn: u64,
    }

    struct PlatformFeeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlatformFeeVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        fee_bps: u64,
        creator: address,
    }

    struct PlatformFeeBpsUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_bps: u64,
        new_fee_bps: u64,
        admin: address,
    }

    struct PlatformFeeCollected has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
        new_total_collected: u64,
    }

    struct PlatformFeeWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        admin: address,
        new_balance: u64,
        new_total_withdrawn: u64,
    }

    public(friend) fun accept_fee<T0>(arg0: &mut PlatformFeeVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        arg0.total_fee_collected = arg0.total_fee_collected + v0;
        let v1 = PlatformFeeCollected{
            vault_id            : 0x2::object::id<PlatformFeeVault<T0>>(arg0),
            amount              : v0,
            new_balance         : 0x2::balance::value<T0>(&arg0.balance),
            new_total_collected : arg0.total_fee_collected,
        };
        0x2::event::emit<PlatformFeeCollected>(v1);
    }

    public fun balance_value<T0>(arg0: &PlatformFeeVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_platform_fee_vault<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 1000, 800);
        let v0 = PlatformFeeVault<T0>{
            id                  : 0x2::object::new(arg1),
            balance             : 0x2::balance::zero<T0>(),
            fee_bps             : arg0,
            total_fee_collected : 0,
            total_fee_withdrawn : 0,
        };
        let v1 = PlatformFeeAdminCap{id: 0x2::object::new(arg1)};
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = PlatformFeeVaultCreated{
            vault_id  : 0x2::object::id<PlatformFeeVault<T0>>(&v0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            fee_bps   : arg0,
            creator   : v2,
        };
        0x2::event::emit<PlatformFeeVaultCreated>(v3);
        0x2::transfer::share_object<PlatformFeeVault<T0>>(v0);
        0x2::transfer::public_transfer<PlatformFeeAdminCap>(v1, v2);
    }

    public fun default_fee_bps() : u64 {
        100
    }

    public fun fee_bps<T0>(arg0: &PlatformFeeVault<T0>) : u64 {
        arg0.fee_bps
    }

    public fun max_fee_bps() : u64 {
        1000
    }

    public fun set_fee_bps<T0>(arg0: &PlatformFeeAdminCap, arg1: &mut PlatformFeeVault<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 800);
        arg1.fee_bps = arg2;
        let v0 = PlatformFeeBpsUpdated{
            vault_id    : 0x2::object::id<PlatformFeeVault<T0>>(arg1),
            old_fee_bps : arg1.fee_bps,
            new_fee_bps : arg2,
            admin       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PlatformFeeBpsUpdated>(v0);
    }

    public fun total_fee_collected<T0>(arg0: &PlatformFeeVault<T0>) : u64 {
        arg0.total_fee_collected
    }

    public fun total_fee_withdrawn<T0>(arg0: &PlatformFeeVault<T0>) : u64 {
        arg0.total_fee_withdrawn
    }

    public fun withdraw_platform_fees<T0>(arg0: &PlatformFeeAdminCap, arg1: &mut PlatformFeeVault<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 801);
        assert!(arg3 != @0x0, 803);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 802);
        arg1.total_fee_withdrawn = arg1.total_fee_withdrawn + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
        let v0 = PlatformFeeWithdrawn{
            vault_id            : 0x2::object::id<PlatformFeeVault<T0>>(arg1),
            amount              : arg2,
            recipient           : arg3,
            admin               : 0x2::tx_context::sender(arg4),
            new_balance         : 0x2::balance::value<T0>(&arg1.balance),
            new_total_withdrawn : arg1.total_fee_withdrawn,
        };
        0x2::event::emit<PlatformFeeWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

