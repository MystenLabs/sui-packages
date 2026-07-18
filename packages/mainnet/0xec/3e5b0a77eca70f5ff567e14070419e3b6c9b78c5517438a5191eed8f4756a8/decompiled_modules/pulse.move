module 0xec3e5b0a77eca70f5ff567e14070419e3b6c9b78c5517438a5191eed8f4756a8::pulse {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct PulseVault<phantom T0> has key {
        id: 0x2::object::UID,
        reward_pool: 0x2::balance::Balance<T0>,
        house_cut: 0x2::balance::Balance<T0>,
        last_tick_ms: u64,
        rate: u64,
        fee_bps: u64,
        ticks: u64,
    }

    struct Ticked has copy, drop {
        vault_id: 0x2::object::ID,
        keeper: address,
        bounty: u64,
        rake: u64,
        tick: u64,
    }

    public fun collect_fees<T0>(arg0: &mut PulseVault<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.vault_id == 0x2::object::uid_to_inner(&arg0.id), 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.house_cut, 0x2::balance::value<T0>(&arg0.house_cut)), arg2)
    }

    public fun fund<T0>(arg0: &mut PulseVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.reward_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun house_cut_value<T0>(arg0: &PulseVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.house_cut)
    }

    public fun new_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(arg1 > 0 && arg2 < 10000, 2);
        let v0 = 0x2::object::new(arg4);
        let v1 = PulseVault<T0>{
            id           : v0,
            reward_pool  : 0x2::coin::into_balance<T0>(arg0),
            house_cut    : 0x2::balance::zero<T0>(),
            last_tick_ms : 0x2::clock::timestamp_ms(arg3),
            rate         : arg1,
            fee_bps      : arg2,
            ticks        : 0,
        };
        0x2::transfer::share_object<PulseVault<T0>>(v1);
        AdminCap{
            id       : 0x2::object::new(arg4),
            vault_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    public fun pending_bounty<T0>(arg0: &PulseVault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = ((0x2::clock::timestamp_ms(arg1) - arg0.last_tick_ms) as u128) * (arg0.rate as u128);
        let v1 = (0x2::balance::value<T0>(&arg0.reward_pool) as u128);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        (v2 as u64)
    }

    public fun reward_pool_value<T0>(arg0: &PulseVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_pool)
    }

    public fun tick<T0>(arg0: &mut PulseVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = pending_bounty<T0>(arg0, arg1);
        assert!(v0 > 0, 0);
        let v1 = (((v0 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        let v2 = 0x2::balance::split<T0>(&mut arg0.reward_pool, v0);
        0x2::balance::join<T0>(&mut arg0.house_cut, 0x2::balance::split<T0>(&mut v2, v1));
        arg0.last_tick_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.ticks = arg0.ticks + 1;
        let v3 = Ticked{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            keeper   : 0x2::tx_context::sender(arg2),
            bounty   : v0,
            rake     : v1,
            tick     : arg0.ticks,
        };
        0x2::event::emit<Ticked>(v3);
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    public fun ticks<T0>(arg0: &PulseVault<T0>) : u64 {
        arg0.ticks
    }

    // decompiled from Move bytecode v7
}

