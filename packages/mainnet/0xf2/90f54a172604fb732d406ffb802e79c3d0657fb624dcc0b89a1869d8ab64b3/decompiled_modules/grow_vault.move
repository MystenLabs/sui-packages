module 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::grow_vault {
    struct GrowVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        perf_fee_bps: u64,
        management_fee_bps: u64,
        withdrawal_fee_bps: u64,
        alternative_assets: u64,
        anticipated_profits: u64,
        last_update_ms: u64,
        cooldown_time_ms: u64,
        last_fee_checkpoint_ms: u64,
        last_fee_checkpoint_sp: u64,
    }

    public(friend) fun burn<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, arg1);
    }

    public(friend) fun mint<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public fun alternative_assets<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.alternative_assets
    }

    public fun anticipated_profits<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.anticipated_profits
    }

    public(friend) fun compute_fees<T0, T1>(arg0: &GrowVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2) - arg0.last_fee_checkpoint_ms;
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = share_price(0x2::coin::total_supply<T1>(&arg0.treasury_cap), arg1);
        let v2 = 0x1::u64::max(arg0.last_fee_checkpoint_sp, v1) - arg0.last_fee_checkpoint_sp;
        if (v2 == 0) {
            return (0, 0, 0)
        };
        let v3 = v1 * arg0.management_fee_bps * v0 / 10000 / 31536000000;
        let v4 = v3;
        let v5 = v2 * arg0.perf_fee_bps / 10000;
        if (v3 + v5 > v2) {
            v4 = v2 - v5;
        };
        (v5 * arg1 / v1, v4 * arg1 / v1, v2)
    }

    public(friend) fun convert_to_assets(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            arg0
        } else {
            arg0 * 1000000000 * arg2 / arg1 / 1000000000
        }
    }

    public(friend) fun convert_to_shares(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            arg0
        } else {
            arg0 * 1000000000 * arg1 / arg2 / 1000000000
        }
    }

    public fun cooldown_time_ms<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.cooldown_time_ms
    }

    public(friend) fun create_vault<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 10000, 9223372212948434945);
        let v0 = GrowVault<T0, T1>{
            id                     : 0x2::object::new(arg5),
            treasury_cap           : arg0,
            perf_fee_bps           : arg1,
            management_fee_bps     : arg2,
            withdrawal_fee_bps     : arg3,
            alternative_assets     : 0,
            anticipated_profits    : 0,
            last_update_ms         : 0,
            cooldown_time_ms       : arg4,
            last_fee_checkpoint_ms : 0,
            last_fee_checkpoint_sp : 1000000000,
        };
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::events::vault_created(0x2::object::id_address<GrowVault<T0, T1>>(&v0), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        0x2::transfer::share_object<GrowVault<T0, T1>>(v0);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::create<T0, T1>(arg5);
    }

    public(friend) fun id<T0, T1>(arg0: &mut GrowVault<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun last_fee_checkpoint_ms<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.last_fee_checkpoint_ms
    }

    public fun last_fee_checkpoint_sp<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.last_fee_checkpoint_sp
    }

    public fun last_update_ms<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.last_update_ms
    }

    public fun management_fee_bps<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.management_fee_bps
    }

    public fun perf_fee_bps<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.perf_fee_bps
    }

    public(friend) fun share_price(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            1000000000
        } else {
            arg1 * 1000000000 / arg0
        }
    }

    public fun treasury_cap<T0, T1>(arg0: &GrowVault<T0, T1>) : &0x2::coin::TreasuryCap<T1> {
        &arg0.treasury_cap
    }

    public(friend) fun update_alt_assets<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: u64) {
        arg0.alternative_assets = arg1;
    }

    public(friend) fun update_assets<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = arg2 - 0x1::u64::min(arg1, arg2);
        if (v0 > 0) {
            arg0.anticipated_profits = v0 + arg3;
            arg0.last_update_ms = 0x2::clock::timestamp_ms(arg4);
        };
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::events::assets_updated(0x2::object::id_address<GrowVault<T0, T1>>(arg0), arg1, arg2, arg3);
    }

    public(friend) fun update_fee_checkpoint<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.last_fee_checkpoint_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.last_fee_checkpoint_sp = share_price(arg1, 0x2::coin::total_supply<T1>(&arg0.treasury_cap));
    }

    public fun withdrawal_fee_bps<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.withdrawal_fee_bps
    }

    // decompiled from Move bytecode v6
}

